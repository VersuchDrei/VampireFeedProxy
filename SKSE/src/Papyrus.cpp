#include "Papyrus.h"

using namespace Papyrus;
using namespace RE;
using namespace RE::BSScript;
using namespace REL;
using namespace SKSE;

namespace {
    constexpr std::string_view PapyrusClass = "VampireFeedProxy";

    void _sub_14092B190(SkyrimVM* vm, Actor* actor, Actor* target) {
        using func_t = decltype(&_sub_14092B190);
        Relocation<func_t> sub_14092B190{RELOCATION_ID(53201, 54012)};
        sub_14092B190(vm, actor, target);
    }

    void SendFeedEvent(StaticFunctionTag*, Actor* actor, Actor* target) {
        const auto vm = SkyrimVM::GetSingleton();
        _sub_14092B190(vm, actor, target);
    }
}

bool Papyrus::RegisterPapyrusFunctions(IVirtualMachine* vm) {
    vm->RegisterFunction("SendFeedEvent", PapyrusClass, SendFeedEvent);

    return true;
}
