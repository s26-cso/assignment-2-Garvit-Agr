#include <stdio.h>
#include<string.h>
#include <dlfcn.h>

typedef int (*fptr)(int,int);

int main() {
    char str[7];
    int a,b;

    while(scanf("%s %d %d",str,&a,&b)==3) {
        char lib[50]={0};
        sprintf(lib,"./lib%s.so",str);
        void* handle=dlopen(lib,RTLD_LAZY);
        fptr func=dlsym(handle,str);
        int ans=func(a,b);
        printf("%d\n",ans);
        dlclose(handle);
    }

    return 0;
}
