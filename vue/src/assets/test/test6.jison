//重复结构
%lex

%% 
\[[\w\s'\\.·•-]+\]                 { return 'SCENE' } // 场景名
\<Role\>.{0,19}|"NARRATOR"         { return 'ROLE'; } // 角色名 ^[A-Z][A-Z0-9\u0020'\\.·•]{0,19}
\'((?!\n\r).)*\'                   { return 'WORDS'; } // 对话
\r\n|[\r\n]                        { return 'EOL'; } // 匹配换行
<<EOF>>               return 'EOF'

/lex

%start story

%%

story //故事
    :events EOF { //事件,全文结束
        console.log("结果res:", $1)
        return $1;
    };

events //事件
    : dialog{ //对话
      $$ = $1
    }  
    | events dialog{
      $$ = $1.concat($2)
    }
    | scene {
      $$ = [$1]
    }   
    ;
scene
  : SCENE LineBreak
    {
      $$ = $1
    }
  ;
dialog //对话
    : role LineBreak words{ //角色 行结束 对话
        $$ =  $1.concat($3)
    };
role //角色
    : ROLE { 
         $$ = $1.replace(/\<Role\>/g,'')}
    };

words //对话
    : lineWords {  //第一行
        $$ = $1
    }
    | words lineWords{
        $$ = $1.concat($2)
    };

lineWords //一行
    :WORDS LineBreak { 
         $$ = $1.replace(/\'/g,'')
    };

// 换行结构
LineBreak
    : EOL{
        console.log("走到这里11")
    }
    | LineBreak  EOL{
        console.log("走到这里22")
    };