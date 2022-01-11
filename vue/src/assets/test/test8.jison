//重复结构
%lex

%% 
("abc")               return 'abc'
<<EOF>>               return 'EOF'

/lex

%start story

%%

story //故事
    :init events EOF { //事件,全文结束
        const scenes = []
        const roles = []
        window.getEventsRoleAndSceneInfo($2,roles)
        const data = {
            roles
        }
        return data;
    };

events //事件
    : abc{ //对话
      $$ = $1
    }  
    ;

init 
    : {
        // if (!window.getEventsRoleAndSceneInfo) {
            window.getEventsRoleAndSceneInfo = function(events,roles){
                events = events.split('')
                console.log("events----",events)
                events.forEach(event => {
                    if(event.includes("a")){
                        roles.push({
                            name:'bb'
                         })
                    }
                })
            }
        $$ = null
    };