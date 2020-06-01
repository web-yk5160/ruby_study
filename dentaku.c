/********************/
/*  電卓プログラム  */
/********************/
#include <stdio.h>
#include <stdlib.h>
int  main(void)
{
    char  c[128],c1[128],op;
    int   x=0,y=0,z=0,i=0,j;

    printf("\n電卓(Ver.1.0)\n");
    printf("\n計算式: "); fgets(c, 128, stdin);      // 計算式入力

    //--１つめの数--
    for( j=0; c[i]>='0' && c[i]<='9'; i++ )
     { c1[j]=c[i]; j++; }               // １文字取り出す
    c1[j]='\0'; x=atoi(c1);             // 整数値に変換

    //--演算子--
    op=c[i]; i++;                       // 演算子を取り出す

    //--２つめの数--
    for( j=0; c[i]>='0' && c[i]<='9'; i++ )
     { c1[j]=c[i]; j++; }               // １文字取り出す
    c1[j]='\0'; y=atoi(c1);             // 整数値に変換

    //--計算実行--
    switch( op )
      {
        case '+': z=x+y; break;
        case '-': z=x-y; break;
        case '*': z=x*y; break;
        case '/': z=x/y; break;
        case '%': z=x%y; break;
        default : printf("\a");         // ブザー
      }

    printf("\n答: %d\n",z);
}