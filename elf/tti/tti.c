#include "tti.h"

inline void settg(int tg) {
    asm volatile
    (
        "settg %[r1]\n\t"
        :
        : [r1] "r" (tg)
    );
}

inline void setti(int ti) {
    asm volatile
    (
        "setti %[r1]\n\t"
        :
        : [r1] "r" (ti)
    );
}

inline int getti() {
    int ti;
    asm volatile
    (
        "getti %[r1]\n\t"
        : [r1] "=r" (ti)
        :
    );
    return ti;
}

inline int getts() {
    int ts;
    asm volatile
    (
        "getts %[r1]\n\t"
        : [r1] "=r" (ts)
        :
    );
    return ts;
}

inline int gettg() {
    int tg;
    asm volatile
    (
        "gettg %[r1]\n\t"
        : [r1] "=r" (tg)
        :
    );
    return tg;
}

inline int ttiat(int * addr, int time) {
    int rd;
    asm volatile
    (
        "ttiat %[r1], (%[r2]), %[r3]\n\t"
        : [r1] "=r" (rd)
        : [r2] "r" (addr), [r3] "r" (time)
    );
    return rd;
}

inline void ttoat(int * addr, int data, int time) {
    asm volatile
    (
        "ttoat %[r1], (%[r2]), %[r3]\n\t"
        :
        : [r1] "r" (data), [r2] "r" (addr), [r3] "r" (time)
    );
}

inline void delay(int time) {
    asm volatile
    (
        "delay %[r1]\n\t"
        :
        : [r1] "r" (time)
    );
}

inline void mtfd(int time) {
    asm volatile
    (
        "mtfd %[r1]\n\t"
        :
        : [r1] "r" (time)
    );
}

inline void tkend() {
    asm volatile
    (
        "tkend\n\t"
        :
        :
    );
}

inline int addtk(int time, int htid) {
    int result;
    asm volatile
    (
        "pushtk %[r1], %[r2], %[r3]\n\t"
        : [r1] "=r" (result)
        : [r2] "r" (time), [r3] "r" (htid)
    );
    return result;
}
