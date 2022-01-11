%lex

%%

\s+         {/* skip whitespace */}       //跳过空格
[0-9]+        {return 'NAT';}             //匹配数字
"+"           {return '+';}               //匹配指定字符+
<<EOF>>       return 'EOF'                //结束

/lex

%%

res //一个变量
    : NAT EOF //一个NAT变量+一个结束标记
        { return $$ =$1*2 }  // $$是返回值，$1对应NAT
    ;

