//===-- HexTypeTreePass.cpp -----------------------------------------------===//
//
// This file is a part of HexType, a type confusion detector.
//
// The HexTypeTreePass has below two functions:
//   - Create object relationship information.
//   - Compile time verification
// This pass will run before all optimization passes run
// The rest is handled by the run-time library.
//===----------------------------------------------------------------------===//

#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Transforms/Instrumentation.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Transforms/Utils/HexTypeUtil.h"
#include "llvm/Transforms/Utils/ModuleUtils.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Analysis/MemoryBuiltins.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/InitializePasses.h"
#include "llvm/IR/InstIterator.h"

#include <cxxabi.h>

#define MAXLEN 10000

using namespace llvm;

namespace {
  struct HexTypeTree : public ModulePass {
    static char ID;
    HexTypeTree() : ModulePass(ID) {
	    //llvm::errs()<<"Create a HexTypeTreePass.\n";
    }

    TargetLibraryInfo *tli;
    TargetLibraryInfoImpl tlii;

    HexTypeLLVMUtil *HexTypeUtilSet;

    void emitPhantomTypeInfo(Module &M) {
      FunctionType *FTy = FunctionType::get(HexTypeUtilSet->VoidTy, false);
      Function *F = Function::Create(FTy, GlobalValue::InternalLinkage,
                                     "__init", &M);

      F->setUnnamedAddr(GlobalValue::UnnamedAddr::Global);
      F->setLinkage(GlobalValue::InternalLinkage);
      F->addFnAttr(Attribute::NoInline);

      BasicBlock *BB = BasicBlock::Create(M.getContext(), "entry", F);
      IRBuilder<> Builder(BB);

      std::string initName = "__update_phantom_info";
      //llvm::errs()<<"getOrInsertFunction() for "<<initName<<"\n";
      FunctionCallee GCOVInit = M.getOrInsertFunction(initName,
                                                 HexTypeUtilSet->VoidTy,
                                                 HexTypeUtilSet->Int64PtrTy);
      Builder.CreateCall(GCOVInit,
                         Builder.CreatePointerCast(
                           HexTypeUtilSet->typePhantomInfoArrayGlobal,
                           HexTypeUtilSet->Int64PtrTy));
      Builder.CreateRetVoid();
      appendToGlobalCtors(M, F, 0);
    }

    void emitExtendObjTraceInst(Module &M, int hashIndex,
                                CallInst *call, int extendTarget) {
      ConstantInt *HashValueConst =
        dyn_cast<ConstantInt>(call->getOperand(1));
      uint64_t TargetHashValue = HashValueConst->getZExtValue();

      if (ClCastObjOpt) {
        bool isSafeObj = true;
        std::set<std::string>::iterator it;
        for (it = HexTypeUtilSet->CastingRelatedSet.begin();
             it != HexTypeUtilSet->CastingRelatedSet.end(); ++it) {
          std::string TargetStr = *it;
          uint64_t TmpHash = HexTypeUtilSet->getHashValueFromStr(TargetStr);
          if (TmpHash == TargetHashValue)
            isSafeObj = false;
        }

        if (isSafeObj) return;
      }

      std::string funName;
      if (extendTarget == PLACEMENTNEW)
        funName.assign("__placement_new_handle");
      else
        funName.assign("__reinterpret_casting_handle");

      Instruction *next = HexTypeUtilSet->findNextInstruction(call);
      IRBuilder<> Builder(next);

      StructElementInfoTy Elements;
      StructType *EmptySet = nullptr;
      Elements.push_back(std::make_pair(TargetHashValue, EmptySet));

      Value *first = Builder.CreatePtrToInt(call->getOperand(0),
                                            HexTypeUtilSet->IntptrTyN);
      Value *second = Builder.CreatePtrToInt(call->getOperand(2),
                                             HexTypeUtilSet->IntptrTyN);
      Value *NewAddr = Builder.CreateAdd(first, second);
      Value *ObjAddrT = Builder.CreateIntToPtr(NewAddr,
                                               HexTypeUtilSet->IntptrTyN);
      HexTypeUtilSet->insertUpdate(&M, Builder, funName, ObjAddrT,
                                   Elements, 0, NULL, NULL, NULL);
      if (ClMakeLogInfo) {
        FunctionCallee ObjUpdateFunction =
          M.getOrInsertFunction(
            "__obj_update_count", HexTypeUtilSet->VoidTy,
            HexTypeUtilSet->Int32Ty,
            HexTypeUtilSet->Int64Ty);
        Value *AllocType;
        if (extendTarget == PLACEMENTNEW)
          AllocType = ConstantInt::get(HexTypeUtilSet->Int32Ty, PLACEMENTNEW);
        else
          AllocType = ConstantInt::get(HexTypeUtilSet->Int32Ty, REINTERPRET);
        Value *TmpOne = ConstantInt::get(HexTypeUtilSet->Int64Ty, 1);
        Value *Param[2] = {AllocType, TmpOne};
        Builder.CreateCall(ObjUpdateFunction, Param);
      }
    }

    void extendClangInstrumentation(Module &M) {
      for (Module::iterator F = M.begin(), E = M.end(); F != E; ++F)
        for (Function::iterator BB = F->begin(), E = F->end(); BB != E;) {
          bool isUpdated = false;
          for (BasicBlock::iterator i = BB->begin(), ie = BB->end();
               i != ie; ++i)
            if (CallInst *call = dyn_cast<CallInst>(&*i))
              if (call->getCalledFunction() != nullptr) {
                std::string FnName = call->getCalledFunction()->getName().str();
                if (FnName.compare("__placement_new_handle") == 0 ||
                    FnName.compare("__reinterpret_casting_handle") == 0) {

                  if (HexTypeUtilSet->AllTypeInfo.size() > 0) {
                    if (FnName.compare("__placement_new_handle") == 0)
                      emitExtendObjTraceInst(M, 1, call, PLACEMENTNEW);
                    else if (FnName.compare("__reinterpret_casting_handle") == 0)
                      emitExtendObjTraceInst(M, 1, call, REINTERPRET);
                  }
                  ////llvm::errs()<<"extendClangInstrumentation : Erase "<<*i<<"\n";
                  (&*i)->eraseFromParent();
                  isUpdated = true;
                  break;
                }
              }
          if(isUpdated == false)
            BB++;
        }
    }

    void emitTypeInfoAsGlobalVal(Module &M) {
      std::string mname = M.getName().str();
      HexTypeUtilSet->syncModuleName(mname);

      char ParentSetGlobalValName[MAXLEN];
      char PhantomSetGlobalValName[MAXLEN];

      strcpy(ParentSetGlobalValName, mname.c_str());
      strcat(ParentSetGlobalValName, ".cinfo");

      HexTypeUtilSet->typeInfoArrayGlobal =
        HexTypeUtilSet->emitAsGlobalVal(M, ParentSetGlobalValName,
                        &(HexTypeUtilSet->typeInfoArray));

      strcpy(PhantomSetGlobalValName, mname.c_str());
      strcat(PhantomSetGlobalValName, "phantom.cinfo");

      HexTypeUtilSet->typePhantomInfoArrayGlobal =
        HexTypeUtilSet->emitAsGlobalVal(M, PhantomSetGlobalValName,
                        &HexTypeUtilSet->typePhantomInfoArray);

      emitPhantomTypeInfo(M);
    }

    bool isAllocCall(CallInst *val) {
      if (isAllocationFn(val, this->tli) &&
          (isMallocOrCallocLikeFn(val, this->tli) ||
           !isAllocLikeFn(val, this->tli)))
        return true;
      return false;
    }

    void collectHeapAlloc(CallInst *call,
                        std::map<CallInst *, Type *> *heapObjsNew) {
      //llvm::errs()<<"Inside collectHeapAlloc : "<<*call<<"\n";
      std::string functionName;
      if (call->getCalledFunction() != nullptr)
        functionName.assign(call->getCalledFunction()->getName().str());

      int unmangledStatus;
      char *unmangledName =
        abi::__cxa_demangle(functionName.c_str(), nullptr,
                            nullptr, &unmangledStatus);
      bool isOverloadedNew = false;
      if (unmangledStatus == 0) {
        std::string unmangledNameStr(unmangledName);
        if (unmangledNameStr.find("::operator new(unsigned long)") !=
            std::string::npos ||
            unmangledNameStr.find(
              "::operator new(unsigned long, std::nothrow_t const&)") !=
            std::string::npos ||
            unmangledNameStr.find("::operator new[](unsigned long)") !=
            std::string::npos ||
            unmangledNameStr.find(
              "::operator new[](unsigned long, std::nothrow_t const&)")
            != std::string::npos) {
          isOverloadedNew = true;
	        //llvm::errs()<<"isOverloadedNew. \n";
        }
	      //llvm::errs()<<"unmangledNameStr = "<<unmangledName<<"\n";
      }



      if (isAllocCall(call) || isOverloadedNew) {
        Type *allocTy = nullptr;
        PointerType *MallocType = nullptr;
        unsigned NumOfBitCastUses = 0;

        for (User *UI : call->users()) {
          if (Instruction *Ins = dyn_cast<Instruction>(UI)) {
            if (BitCastInst *BCI = dyn_cast<BitCastInst>(Ins)) {
              MallocType = cast<PointerType>(BCI->getDestTy());
              NumOfBitCastUses++;
            }
          }
        }

        if (NumOfBitCastUses == 1)
          allocTy = MallocType->getElementType();
        
        if (NumOfBitCastUses == 0)
          allocTy = cast<PointerType>(call->getType())->getElementType();

        if (allocTy)//call->getType())////getMallocAllocatedType(call, this->tli))
          if (HexTypeUtilSet->isInterestingType(allocTy))
            heapObjsNew->insert(
              std::pair<CallInst *, Type *>(call, allocTy));
      }
      return;
    }

    void collectFree(CallInst *call, Instruction *InstPrev,
                   std::map<CallInst *, Type *> *heapObjsFree) {
      if (isFreeCall(call, this->tli))
        if (const BitCastInst *BCI = dyn_cast<BitCastInst>(InstPrev))
          if (PointerType *FreeType =
              cast<PointerType>(BCI->getSrcTy())) {
            Type *VTy = FreeType->getElementType();
            if (HexTypeUtilSet->isInterestingType(VTy))
                heapObjsFree->insert(
                  std::pair<CallInst *, Type *>(call, VTy));
          }

      return;
    }

    bool isReallocFn(Function *F) {
      std::string funName = F->getName().str();
      if ((funName.find("realloc") != std::string::npos))
        return true;

      return false;
    }

    void handleHeapAlloc(Module &M, std::map<CallInst *, Type *> *heapObjsNew) {
      //llvm::errs()<<"handleHeapAlloc.\n";
      for (std::map<CallInst *, Type *>::iterator it=heapObjsNew->begin();
           it!=heapObjsNew->end(); ++it) {
        //llvm::errs()<<"CallInst : "<<*it->first<<"\n";
        Instruction *next = HexTypeUtilSet->findNextInstruction(it->first);
        IRBuilder<> Builder(next);

        bool isRealloc = 0;

        StructElementInfoTy offsets;
        HexTypeUtilSet->getArrayOffsets(it->second, offsets, 0);
        //llvm::errs()<<"offset.size = "<<offsets.size()<<"\n";
        if (offsets.size() == 0) continue;

        Value *ArraySize;
        Value *TypeSize;
        Value *ArraySizeF = nullptr;

        if (isMallocLikeFn(it->first, this->tli) ||
            !isAllocLikeFn(it->first, this->tli) ||
            !isAllocationFn(it->first, this->tli)) {
          if (isMallocLikeFn(it->first, this->tli) ||
              !isAllocationFn(it->first, this->tli)) {
            //llvm::errs()<<"MalloclikeFn"
            ArraySize = it->first->getArgOperand(0);
            //llvm::errs()<<"ArraySize = it->first->getArgOperand(0);\n";
          }
          else {
           ArraySize = it->first->getArgOperand(1);
           //llvm::errs()<<"ArraySize = it->first->getArgOperand(1);\n";
          }

          /*if (isMallocOrCallocLikeFn(it->first, this->tli) ||
              !isAllocationFn(it->first, this->tli))
            ArraySize = it->first->getArgOperand(0);
          else
            ArraySize = it->first->getArgOperand(1);*/

          unsigned long TypeSizeVal =
            HexTypeUtilSet->DL.getTypeAllocSize(it->second);
          TypeSize = ConstantInt::get(HexTypeUtilSet->Int64Ty, TypeSizeVal);

          if (TypeSizeVal != 0)
            ArraySizeF = Builder.CreateUDiv(ArraySize, TypeSize);
          else
            ArraySizeF = ArraySize;

          if (isReallocFn(it->first->getCalledFunction())) {
            isRealloc = true;
            //llvm::errs()<<"isRealloc = true \n";
          }
        }
        else if (isCallocLikeFn(it->first, this->tli)){
          ArraySizeF = it->first->getArgOperand(1);
          //llvm::errs()<<"isCallocLikeFn \n";
        }

        if (ArraySizeF) {
          if (isRealloc == 1) {
            //llvm::errs()<<"isRealloc == 1\n";
            HexTypeUtilSet->insertUpdate(&M, Builder, "__update_realloc_oinfo",
                                         (Value *)(it->first), offsets,
                                         HexTypeUtilSet->DL.getTypeAllocSize(
                                           it->second), ArraySizeF,
                                         (Value *)(it->first->getArgOperand(0)),
                                         NULL);
          }
          else {
            //llvm::errs()<<"isRealloc != 1\n";
            HexTypeUtilSet->insertUpdate(&M, Builder, "__update_heap_oinfo",
                                         (Value *)(it->first), offsets,
                                         HexTypeUtilSet->DL.getTypeAllocSize(
                                           it->second), ArraySizeF,
                                         NULL, NULL);
          }
        }
      }
    }

    void handleFree(Module &M, std::map<CallInst *, Type *> *heapObjsFree) {
      for (std::map<CallInst *, Type *>::iterator it=heapObjsFree->begin();
           it!=heapObjsFree->end(); ++it) {
        Instruction *next = HexTypeUtilSet->findNextInstruction(it->first);
        IRBuilder<> Builder(next);
        StructElementInfoTy offsets;
        HexTypeUtilSet->getArrayOffsets(it->second, offsets, 0);
        HexTypeUtilSet->insertRemove(&M, Builder, "__remove_heap_oinfo",
                                     it->first->getArgOperand(0), offsets,
                                     0, HexTypeUtilSet->DL.getTypeAllocSize(
                                       it->second),
                                     NULL);
      }
    }

    void heapObjTracing(Module &M) {
      Instruction *InstPrev;
      this->tli = new TargetLibraryInfo(tlii);
      std::map<CallInst *, Type *> heapObjsFree, heapObjsNew;
      for (Module::iterator F = M.begin(), E = M.end(); F != E; ++F)
        for (Function::iterator BB = F->begin(), E = F->end(); BB != E; ++BB) {
          for (BasicBlock::iterator i = BB->begin(),
               ie = BB->end(); i != ie; ++i) {
            if (CallInst *call = dyn_cast<CallInst>(&*i)) {
              collectHeapAlloc(call, &heapObjsNew);
              collectFree(call, InstPrev, &heapObjsFree);
            }
            InstPrev = &*i;
          }

          handleHeapAlloc(M, &heapObjsNew);
          handleFree(M, &heapObjsFree);

          heapObjsFree.clear();
          heapObjsNew.clear();
        }
    }

    bool isLocalPointer(Value *target, Module::iterator F) {
      ////llvm::errs()<<"Check isLocalPtr :"<<*target<<" : "<<target<<"\n";
      for (Function::iterator BB = F->begin(), E = F->end(); BB != E; ++BB)
        for (BasicBlock::iterator t = BB->begin(), te = BB->end();
             t != te; ++t) {
          ////llvm::errs()<<"ins : "<<&*t<<" : "<<*t<<"\n";
          if (target == dyn_cast<AllocaInst>(&*t)) {
            ////llvm::errs()<<"return true.\n";
            return true;
          }
        }
      return false;
    }

    bool isSafePointer(Value *target, Module::iterator F, Module *M) {
      if (!isLocalPointer(target, F))
        return false;

      for (Function::iterator BB = F->begin(), E = F->end(); BB != E; ++BB)
        for (BasicBlock::iterator t = BB->begin(), te = BB->end();
             t != te; ++t)
          if (StoreInst *AI = dyn_cast<StoreInst>(&*t))
            if (target == AI->getPointerOperand())
              if (!isSafeSrcValue(AI->getValueOperand(), F, M))
                return false;
      ////llvm::errs()<<"isSafePointer : "<<*target<<"\n";
      return true;
    }

    bool isHeapObj(CallInst *call) {
      bool isOverloadedNew = false;
      std::string functionName = "";
      if (call->getCalledFunction() != nullptr)
        functionName = call->getCalledFunction()->getName().str();

      this->tli = new TargetLibraryInfo(tlii);
      int unmangledStatus;
      char *unmangledName =
        abi::__cxa_demangle(functionName.c_str(), nullptr,
                            nullptr, &unmangledStatus);
      if (unmangledStatus == 0) {
        std::string unmangledNameStr(unmangledName);
        if (unmangledNameStr.find("::operator new(unsigned long)") !=
            std::string::npos ||
            unmangledNameStr.find(
              "::operator new(unsigned long, std::nothrow_t const&)") !=
            std::string::npos ||
            unmangledNameStr.find("::operator new[](unsigned long)") !=
            std::string::npos ||
            unmangledNameStr.find(
              "::operator new[](unsigned long, std::nothrow_t const&)")
            != std::string::npos) {
          isOverloadedNew = true;
        }
      }

      if (isAllocCall(call) || isOverloadedNew)
        if (Type *allocTy = call->getType())////getMallocAllocatedType(call, this->tli))
          if (HexTypeUtilSet->isInterestingType(allocTy))
            return true;

      return false;
    }

    bool isSafeSrcValue(Value *SrcValue, Module::iterator F,
                     Module *M) {
      // source is global variable
      for (llvm::Module::global_iterator ii = M->global_begin();
           ii != M->global_end(); ++ii) {
        if (&*ii == SrcValue)
          return true;
      }

      for (Function::iterator BB = F->begin(), E = F->end(); BB != E; ++BB)
        for (BasicBlock::iterator t = BB->begin(), te = BB->end();
             t != te; ++t) {
          if (SrcValue == (&*t)) {
            // source type is local stack value
            if (AllocaInst *AI = dyn_cast<AllocaInst>(&*t)) {
              if (HexTypeUtilSet->isInterestingType(AI->getAllocatedType()) &&
                  isa<StructType>(AI->getAllocatedType()))
                return true;

              else if(AI->getAllocatedType()->isPointerTy())
                if(isSafePointer(AI, F, M))
                  return true;
              return false;
            }

            // source type is heap object
            CallInst *call = dyn_cast<CallInst>(&*t);
            if (call) {
              if (isHeapObj(call))
                return true;
              return false;
            }

            // if source type is array (not pointer)
            if (GEPOperator *GO = dyn_cast<GEPOperator>(&*t))
              if (isa<StructType>(GO->getResultElementType()))
                return true;

            // if source type is pointer
            if (LoadInst *AI = dyn_cast<LoadInst>(&*t))
              if (isSafePointer(AI->getPointerOperand(), F, M))
                return true;

            // check store instruction
            if (StoreInst *AI = dyn_cast<StoreInst>(&*t))
              if (isSafeSrcValue(AI->getValueOperand(), F, M))
                return true;

            // if source type is related to bitcast
            if (const BitCastInst *BCI = dyn_cast<BitCastInst>(&*t))
              if (isSafeSrcValue(BCI->getOperand(0), F, M))
                return true;
          }
        }

      return false;
    }

    bool compiletime_verification(Value *SrcValue, Module::iterator F,
                                  Module *M) {
      if (isSafeSrcValue(SrcValue, F, M)) {
        // PointerType *FreeType = nullptr;
        // Type *DstTy= nullptr;
        // compile_time_verification(src, dst);
        return true;
      }
      return false;
    }

    void compileTimeVerification(Module &M) {
      for (Module::iterator F = M.begin(), E = M.end(); F != E; ++F)
        for (Function::iterator BB = F->begin(), E = F->end(); BB != E;) {
          bool isRemoved = false;
          for (BasicBlock::iterator i = BB->begin(),
               ie = BB->end(); i != ie; ++i)
            if (CallInst *call = dyn_cast<CallInst>(&*i))
              if (call->getCalledFunction() != nullptr) {
                std::string functionName = call->getCalledFunction()->getName().str();
                if ((functionName.compare("__type_casting_verification") == 0 ||
                     functionName.compare("__type_casting_verification_changing") == 0))
                  if (PtrToIntInst *SrcValue =
                      dyn_cast<PtrToIntInst>(call->getArgOperand(0)))
                    if (compiletime_verification(SrcValue->getPointerOperand(),
                                                 F, &M)) {
                      ////llvm::errs()<<"compileTimeVerification : Erase "<<*i<<"\n";
                      ////llvm::errs()<<"safe compilation time verification : "<<*i<<"\n";
                      (&*i)->eraseFromParent();
                      
                      isRemoved = true;
                      break;
                    }
              }

          ////if(isRemoved == false)
          BB++;
        }
    }
    bool isSafeCast(CastInst *CI) {
      
    }
    void eraseCustomTypeCheck(Module &M) {
      std::set<Instruction*> inst_set;
      for (Module::iterator F = M.begin(), E = M.end(); F != E; ++F) {
        for (inst_iterator itr = inst_begin(*F), ite = inst_end(*F); itr != ite; ++itr) {
          llvm::Instruction *I = &*itr;
          /*if (CastInst *CI = dyn_cast<CastInst>(I)) {
            llvm::errs()<<"Pass CI : "<<*CI<<"\n";
            llvm::errs()<<"NexNode : "<<*I->getPrevNode()<<"\n";
            if (isSafeCast(CI)) {
              llvm::Instruction *II = I->getPrevNode();
              if (CallInst *call = dyn_cast<CallInst>(II)) {
                if (call->getCalledFunction() != nullptr) {
                  std::string functionName = call->getCalledFunction()->getName().str();
                  if (functionName.compare("__type_casting_verification") == 0) {
                    //call->eraseFromParent();
                  }
                }
              }
            }
          }*/
        }
      }
    }
    void typecastinginlineoptimization(Module &M)  {
      GlobalVariable* ResultCache = HexTypeUtilSet->getVerifyResultCache(M);
      GlobalVariable* GObjTypeMap = HexTypeUtilSet->getObjTypeMap(M);
      for (Module::iterator F = M.begin(), E = M.end(); F != E; ++F)
        for (Function::iterator BB = F->begin(),
             E = F->end(); BB != E;) {
          bool update = false;
          for (BasicBlock::iterator i = BB->begin(),
               ie = BB->end(); i != ie; ++i)
            if (CallInst *call = dyn_cast<CallInst>(&*i)) {
              if (call->getCalledFunction() != nullptr) {
                std::string functionName = call->getCalledFunction()->getName().str();
                if (functionName.compare("__type_casting_verification") == 0) {
                  update = true;
                  Instruction *next = HexTypeUtilSet->findNextInstruction(call);

                  ////llvm::errs()<<"inline-opt : "<<*next<<"\n";
                  IRBuilder<> Builder(next);
                  ////llvm::errs()<<"(3-0) check whether src addr is NULL.\n";
                  // (3-0) check whether src addr is NULL
                  Value* isNotNull =
                    Builder.CreateIsNotNull(call->getArgOperand(0));
                  Instruction *InsertPtMain = &*Builder.GetInsertPoint();
                  Instruction *ThenTermNotNull, *ElseTermNotNull;
                  SplitBlockAndInsertIfThenElse(isNotNull,
                                                InsertPtMain, &ThenTermNotNull,
                                                &ElseTermNotNull, nullptr);

                  // (3-1) get index using src address
                  ////llvm::errs()<<"(3-1) get index using src address.\n";
                  Builder.SetInsertPoint(ThenTermNotNull);
                  Value *newPtr =
                    Builder.CreatePtrToInt(call->getArgOperand(0),
                                           HexTypeUtilSet->IntptrTyN);
                  Value *ptrValueT =
                    Builder.CreateIntToPtr(newPtr, HexTypeUtilSet->IntptrTyN);
                  Value *ShVal = Builder.CreateLShr(newPtr, 3);
                  Value *mapSize =
                    ConstantInt::get(HexTypeUtilSet->IntptrTyN, 268435455);
                  Value *mapIndex = Builder.CreateAnd(ShVal, mapSize);
                  Value *mapIndex64 =
                    Builder.CreatePtrToInt(mapIndex, HexTypeUtilSet->Int64Ty);

                  // (3-2) access ObjTypeMap using index
                  ////llvm::errs()<<"(3-2) access ObjTypeMap using index.\n";
                  Value* ObjTypeMapInit= Builder.CreateLoad(GObjTypeMap); //(cast<PointerType>(Ptr->getType()->getScalarType())
                  Value* TargetIndexAddr =
                    Builder.CreateGEP((cast<PointerType>(ObjTypeMapInit->getType())->getElementType()), ObjTypeMapInit, mapIndex, "");
                  Value* TargetIndexAddrValueAddr =
                    Builder.CreateGEP((cast<PointerType>(TargetIndexAddr->getType())->getElementType()),TargetIndexAddr,
                                      {ConstantInt::get(
                                          HexTypeUtilSet->Int32Ty, 0),
                                      ConstantInt::get(
                                        HexTypeUtilSet->Int32Ty, 0)}, "");

                  Value* TargetIndexAddrValue =
                    Builder.CreateLoad(TargetIndexAddrValueAddr);
                  Value* isEqual = Builder.CreateICmpEQ(ptrValueT,
                                                        TargetIndexAddrValue);
                  Instruction *InsertPt = &*Builder.GetInsertPoint();
                  Instruction *ThenTerm , *ElseTerm ;
                  SplitBlockAndInsertIfThenElse(isEqual,
                                                InsertPt, &ThenTerm,
                                                &ElseTerm, nullptr);

                  // (4) check whether ObjTypeMap[index].addr == src
                  Builder.SetInsertPoint(ThenTerm);
                  // (4-1) get src hash value
                  ////llvm::errs()<<"(4-1) get src hash value.\n";
                  TargetIndexAddrValueAddr =
                    Builder.CreateGEP((cast<PointerType>(TargetIndexAddr->getType())->getElementType()),TargetIndexAddr,
                                      {ConstantInt::get(
                                          HexTypeUtilSet->Int32Ty, 0),
                                      ConstantInt::get(
                                        HexTypeUtilSet->Int32Ty, 2)}, "");
                  // (4-2) get index using src and dst Hash Value
                  TargetIndexAddrValue =
                    Builder.CreateLoad(TargetIndexAddrValueAddr);

                  // (4-3), (src & 0xfff);
                  Value *srcIndex =
                    Builder.CreateBitCast(TargetIndexAddrValue,
                                          HexTypeUtilSet->Int64Ty);
                  Value *andValue =
                    ConstantInt::get(HexTypeUtilSet->Int64Ty, 4095);
                  Value *leftMapIndex = Builder.CreateAnd(srcIndex, andValue);

                  // (4-4), idxCache <<= 12;
                  Value *curValue = Builder.CreateShl(leftMapIndex, 12);

                  // (4-5), idxCache |= (dst & 0xfff);
                  ConstantInt *constantHashValue2 =
                    dyn_cast<ConstantInt>(call->getArgOperand(1));
                  Value *dstValue = ConstantInt::get(
                    HexTypeUtilSet->Int64Ty,
                    constantHashValue2->getZExtValue());
                  Value *rightValue = Builder.CreateAnd(dstValue, andValue);
                  Value *cacheIndex = Builder.CreateOr(curValue, rightValue);

                  // (4-6), verifiedResultCache[idxCache].srcHValue == src &&
                  //        verifiedResultCache[idxCache].dstHValue == dst
                  Value* ResultCacheInit = Builder.CreateLoad(ResultCache);
                  TargetIndexAddr =
                    Builder.CreateGEP((cast<PointerType>(ResultCacheInit->getType())->getElementType()),ResultCacheInit, cacheIndex, "");
                  Value* TargetIndexAddrValueAddrT =
                    Builder.CreateGEP((cast<PointerType>(TargetIndexAddr->getType())->getElementType()),TargetIndexAddr,
                                      {ConstantInt::get(
                                          HexTypeUtilSet->Int32Ty, 0),
                                      ConstantInt::get(
                                        HexTypeUtilSet->Int32Ty, 0)}, "");
                  TargetIndexAddrValue =
                    Builder.CreateLoad(TargetIndexAddrValueAddrT);
                  Value *srcisEqual =
                    Builder.CreateICmpEQ(srcIndex, TargetIndexAddrValue);
                  TargetIndexAddrValueAddrT =
                    Builder.CreateGEP((cast<PointerType>(TargetIndexAddr->getType())->getElementType()),TargetIndexAddr,
                                      {ConstantInt::get(
                                          HexTypeUtilSet->Int32Ty, 0),
                                      ConstantInt::get(
                                        HexTypeUtilSet->Int32Ty, 1)}, "");
                  TargetIndexAddrValue =
                    Builder.CreateLoad(TargetIndexAddrValueAddrT);
                  Value *dstisEqual =
                    Builder.CreateICmpEQ(dstValue, TargetIndexAddrValue);
                  llvm::Value *isSatisfied =
                    Builder.CreateAnd(srcisEqual, dstisEqual);
                  Instruction *InInsertPt = &*Builder.GetInsertPoint();
                  Instruction *InThenTerm , *InElseTerm;
                  SplitBlockAndInsertIfThenElse(isSatisfied,
                                                InInsertPt, &InThenTerm,
                                                &InElseTerm, nullptr);
                  // (4-7) print cache result
                  Builder.SetInsertPoint(InThenTerm);
                  Value *GetCacheResult =
                    Builder.CreateGEP((cast<PointerType>(TargetIndexAddr->getType())->getElementType()),TargetIndexAddr,
                                      {ConstantInt::get(
                                          HexTypeUtilSet->Int32Ty, 0),
                                      ConstantInt::get(
                                        HexTypeUtilSet->Int32Ty, 2)}, "");
                  Value *TargetIndexAddrValueCache =
                    Builder.CreateLoad(GetCacheResult);
                  Value *BadCast = ConstantInt::get(HexTypeUtilSet->Int8Ty, 0);
                  Value *isEqualCacheResult =
                    Builder.CreateICmpEQ(TargetIndexAddrValueCache, BadCast);
                  Instruction *InInsertCachePt = &*Builder.GetInsertPoint();
                  Instruction *InThenCacheTerm , *InElseCacheTerm ;

                  if (ClMakeLogInfo) {
                    FunctionCallee objUpdateFunction =
                      M.getOrInsertFunction(
                        "__lookup_success_count", HexTypeUtilSet->VoidTy,
                        HexTypeUtilSet->Int8Ty);
                    Value *Param[1] = { TargetIndexAddrValueCache };
                    Builder.CreateCall(objUpdateFunction, Param);
                  }

                  SplitBlockAndInsertIfThenElse(isEqualCacheResult,
                                                InInsertCachePt,
                                                &InThenCacheTerm,
                                                &InElseCacheTerm, nullptr);
                  Builder.SetInsertPoint(InThenCacheTerm);
                  FunctionCallee initFunction =
                    M.getOrInsertFunction(
                      "__type_casting_verification_print_cache_result",
                      HexTypeUtilSet->VoidTy,
                      HexTypeUtilSet->Int64Ty);
                  Value *ParamTypeCache[1] = { cacheIndex };
                  Builder.CreateCall(initFunction, ParamTypeCache);
                  Builder.SetInsertPoint(InInsertCachePt);
                  Builder.SetInsertPoint(InElseCacheTerm);
                  Builder.SetInsertPoint(InInsertCachePt);
                  Builder.SetInsertPoint(InInsertPt);
                  Builder.SetInsertPoint(InElseTerm);
                  initFunction =
                    M.getOrInsertFunction(
                      "__type_casting_verification_inline",
                      HexTypeUtilSet->VoidTy,
                      HexTypeUtilSet->Int64Ty,
                      HexTypeUtilSet->Int64Ty,
                      HexTypeUtilSet->Int64Ty,
                      HexTypeUtilSet->Int64Ty);
                  Value *Param[4] = {srcIndex, dstValue,
                    mapIndex64, cacheIndex};
                  Builder.CreateCall(initFunction, Param);
                  Builder.SetInsertPoint(InInsertPt);
                  Builder.SetInsertPoint(InsertPt);
                  Builder.SetInsertPoint(ElseTerm);
                  // (5) call normal check function
                  initFunction =
                    M.getOrInsertFunction(
                      "__type_casting_verification_inline_normal",
                      HexTypeUtilSet->VoidTy,
                      HexTypeUtilSet->IntptrTyN,
                      HexTypeUtilSet->Int64Ty);
                  Value *Param_elseterm[2] = { newPtr, dstValue };
                  Builder.CreateCall(initFunction, Param_elseterm);
                  ////llvm::errs()<<"typecastinginlineoptimization : Erase : "<<*i<<"\n";
                  (&*i)->eraseFromParent();
                  Builder.SetInsertPoint(InsertPt);
                  Builder.SetInsertPoint(InsertPtMain);
                  Builder.SetInsertPoint(ElseTermNotNull);
                  Builder.SetInsertPoint(InsertPtMain);
                  break;
                }
              }
            }
          if(update == false)
            BB++;
        }
    }

    StringRef getPassName() const override {
	    return "HexTypeTreePass";
    }
    virtual bool runOnModule(Module &M) {
	  //llvm::errs()<<"runOnModule : "<<M.getName().str()<<"\n";
      // Init HexTypeUtil
      HexTypeLLVMUtil HexTypeUtilSetT(M.getDataLayout());
      HexTypeUtilSet = &HexTypeUtilSetT;
      HexTypeUtilSet->initType(M);

      // Create type releationship information
      HexTypeUtilSet->createObjRelationInfo(M);
      if (HexTypeUtilSet->AllTypeInfo.size() > 0)
        emitTypeInfoAsGlobalVal(M);

      // Init for only tracing casting related objects
      if (ClCastObjOpt || ClCreateCastRelatedTypeList)
        HexTypeUtilSet->setCastingRelatedSet();
      if (ClCreateCastRelatedTypeList)
        HexTypeUtilSet->extendCastingRelatedTypeSet();

      // Apply typecasting inline optimization
      if (ClInlineOpt)
        typecastinginlineoptimization(M);
      
      ////eraseCustomTypeCheck(M);
      // Apply compile time verfication optimization
      if (ClCompileTimeVerifyOpt)
        compileTimeVerification(M);
      //llvm::errs()<<"heapObjTracing(M). \n";
      // Heap object trace
      heapObjTracing(M);
      //llvm::errs()<<"extendClangInstrumentation(M). \n";
      // Extend HexType's clang Instrumentation
      extendClangInstrumentation(M);

      return false;
    }
  };
}

//register pass
char HexTypeTree::ID = 0;

INITIALIZE_PASS(HexTypeTree, "HexTypeTree",
                "HexTypePass: fast type safety for C++ programs.",
                false, false)

ModulePass *llvm::createHexTypeTreePass() {
  //llvm::errs()<<"createHexTypeTreePass().\n";
  return new HexTypeTree();
}
