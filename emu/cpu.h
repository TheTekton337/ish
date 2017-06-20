#ifndef EMU_H
#define EMU_H

#include <stddef.h>
#include "misc.h"
#include "emu/memory.h"

struct cpu_state;
void cpu_run(struct cpu_state *cpu);
int cpu_step32(struct cpu_state *cpu);
int cpu_step16(struct cpu_state *cpu);

union xmm_reg {
    qword_t qw[2];
    dword_t dw[4];
    // TODO more forms
};

struct cpu_state {
    struct mem mem;

    // assumes little endian (as does literally everything)
#define _REG(n) \
    union { \
        dword_t e##n; \
        word_t n; \
    };
#define _REGX(n) \
    union { \
        dword_t e##n##x; \
        word_t n##x; \
        struct { \
            byte_t n##l; \
            byte_t n##h; \
        }; \
    };

    _REGX(a);
    _REGX(b);
    _REGX(c);
    _REGX(d);
    _REG(si);
    _REG(di);
    _REG(bp);
    _REG(sp);
#undef REGX
#undef REG

    union xmm_reg xmm[8];

    dword_t eip;

    // flags
    bits pf:1;
    bits af:1;
    bits zf:1;
    bits sf:1;
    bits tf:1;
    bits df:1;
    // whether the true flag values are in the above struct, or computed from
    // the stored result
    dword_t res;
    bits pf_res:1;
    bits zf_res:1;
    bits sf_res:1;
    // these guys are constantly set manually so I can save a few instructions
    // by making them entire bytes
    byte_t of;
    byte_t cf;

    // See comment in sys/tls.c
    addr_t tls_ptr;

    // for the page fault handler
    addr_t segfault_addr;
};

typedef uint8_t reg_id_t;
#define REG_ID(reg) offsetof(struct cpu_state, reg)
#define REG_VAL(cpu, reg_id, size) (*((uint(size) *) (((char *) (cpu)) + reg_id)))
inline const char *reg8_name(uint8_t reg_id) {
    switch (reg_id) {
        case REG_ID(al): return "al";
        case REG_ID(bl): return "bl";
        case REG_ID(cl): return "cl";
        case REG_ID(dl): return "dl";
        case REG_ID(ah): return "ah";
        case REG_ID(bh): return "bh";
        case REG_ID(ch): return "ch";
        case REG_ID(dh): return "dh";
    }
    return "??";
}
inline const char *reg16_name(uint8_t reg_id) {
    switch (reg_id) {
        case REG_ID(ax): return "ax";
        case REG_ID(bx): return "bx";
        case REG_ID(cx): return "cx";
        case REG_ID(dx): return "dx";
        case REG_ID(si): return "si";
        case REG_ID(di): return "di";
        case REG_ID(bp): return "bp";
        case REG_ID(sp): return "sp";
    }
    return "??";
}
inline const char *reg32_name(uint8_t reg_id) {
    switch (reg_id) {
        case REG_ID(eax): return "eax";
        case REG_ID(ebx): return "ebx";
        case REG_ID(ecx): return "ecx";
        case REG_ID(edx): return "edx";
        case REG_ID(esi): return "esi";
        case REG_ID(edi): return "edi";
        case REG_ID(ebp): return "ebp";
        case REG_ID(esp): return "esp";
    }
    return "???";
}

#endif
