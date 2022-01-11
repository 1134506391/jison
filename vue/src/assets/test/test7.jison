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
    :init events EOF { //事件,全文结束
        const scenes = []
        const roles = []
        console.log("结果11",$1)
        window.getEventsRoleAndSceneInfo($2,roles,scenes)
        console.log("结果res:", $2)
        console.log("roles--",roles)
        const data = {
            roles,
            scenes
        }
        console.log("data",data)
        return data;
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
    | events scene {
      $$ = $1.concat($2)
    } 
    ;
scene
  : SCENE LineBreak
    {
      $$ = {
        type: 1,
        sceneName: $1.replace(/^\[|\]$/g,'').toUpperCase()
      }
    }
  ;
dialog //对话
    : role LineBreak words{ //角色 行结束 对话
        console.log("Role",$1)
        console.log("Words",$3)
        $3.forEach(word => {
            console.log('wrodd',word)
            word.roleName = $1
        })
        // $$ = $3
        $$ = $3
        //  $$ = $1.concat($3)
    };
role //角色
    : ROLE { 
         $$ = $1.replace(/\<Role\>/g,'').replace(/\s*$/g, '')
    };

words //对话
    : lineWords { 
        console.log("/第一行话")
        console.log("LineWords",$1)
        // const text = $1.text
        // console.log("text",text)
        // const wordList = []
        // $1.text.forEach(item => {
        //     wordList.push({
        //         text:$1
        //     })
        // })
        const wordList = []
         wordList.push({
                text:$1
            })
        $$ = wordList
    }
    | words lineWords{
        console.log("第多行话")
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

init 
    : {
        window.roleNameRecordObj = {}
        // if (!window.getEventsRoleAndSceneInfo) {
            window.getEventsRoleAndSceneInfo = function(events,roles,scenes){
                console.log("events----",events)
                events.forEach(event => {
                    if(event.type == 1){
                        scenes.push({
                            name:event.sceneName
                         })
                    }else if(event.roleName){
                        roles.push({
                            characterName:event.roleName
                        })
                    }
                })
            }
        // }
        $$ = null
    };