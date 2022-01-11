//重复结构
%lex

%% 
\<Role\>.{0,19}|"NARRATOR"         { return 'ROLE'; } // 角色名 ^[A-Z][A-Z0-9\u0020'\\.·•]{0,19}
\r\n|[\r\n]                        { return 'EOL'; } // 匹配换行
<<EOF>>               return 'EOF'

/lex

%start story

%%

story //故事
    : events EOF { //事件,全文结束
        return $1;
    };

events //事件
    : role{ //对话
      $$ = $1
    }  
    | events role{
      $$ = $1.concat($2)
    }
    ;
role //角色
    : ROLE LineBreak { 
          $$ = $1
    };
// 换行结构
LineBreak
    : EOL{
        console.log("走到这里11")
    }
    | LineBreak  EOL{
        console.log("走到这里22")
    };