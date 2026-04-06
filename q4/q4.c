#include <stdio.h>
#include <dlfcn.h>

typedef int (*fptr)(int,int);

int main() {
    char str[7];
    int a,b;

    while(scanf("%s %d %d",str,&a,&b)==3) {
        void* handle=dlopen("./libadd.so",RTLD_LAZY);
        fptr func=dlsym(handle,str);
        int ans=func(a,b);
        printf("%d\n",ans);
    }

    return 0;
}
