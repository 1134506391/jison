/**
  1、全局安装jison，npm install jison -g
  2、编写解析器生成器代码，story.jison
  2、根据生成器代码，生成解析器js文件，此目录下执行： jison story_editor_2.jison --outfile storyParser_2.js
**/

// 句子 \[([\n\r]*.*[\n\r]*)+?\]

%lex
%%
// 2.0 场景名称
\[[\w\s'\\.·•-]+\]                 { return 'SCENE' } // 场景名
\<Role\>.{0,19}|"NARRATOR"         { return 'ROLE'; } // 角色名 ^[A-Z][A-Z0-9\u0020'\\.·•]{0,19}
\'((?!\n\r).)*\'                   { return 'WORDS'; } // 对话
\(.+\)                             { return 'THOUGHT'; } // 内心独白
\<Choice\>.*                       { return 'CHOICE_HEAD'; } // 选项头
\<Dress\-up\>.*                    { return 'DRESS_HEAD'; } // 换装头
\<Branch\>.*                       { return 'BRANCH_HEAD'; } // 分支头
\<Option\>.*                       { return 'OPTION'; } // 选项内容
"{"                                { return '{'; }
"}"                                { return '}'; }
\r\n|[\r\n]                        { return 'EOL'; } // 匹配换行
<<EOF>>                            { return 'EOF'; } // 匹配文本结束

/lex

%start story // 直接指定哪个规则先执行

%%

story // 第一条规则先执行
  : init events EOF
    {
      const scenes = []
      const roles = []
      // 遍历主剧情事件
      window.getEventsRoleAndSceneInfo($2, roles, scenes)

      // 遍历子剧情
      window.subPlots.forEach(plot => {
        window.getEventsRoleAndSceneInfo(plot.events, roles, scenes)
      })
      const data = {
        events: $2,
        subPlots: window.subPlots,
        roles,
        scenes
      }
      window.subPlots = []
      window.roleNameRecordObj = {}
      window.sceneNameRecordObj = {}
      return data;
    }
  ;

/**
* 事件类型
* 1：场景
* 2: 普通对话
* 3：内心独白
* 4: 选择
* 5：换装
* 6：分支
**/
events
  : dialog
    {
      $$ = $1
    }
  | scene
    {
      $$ = [$1]
    }
  | branch
    {
      $$ = [$1]
    }
  | events dialog
    {
      $$ = $1.concat($2)
    }
  | events scene
    {
      $$ = $1.concat($2)
    }
  | events branch
    {
      $$ = $1.concat($2)
    }
  | events LineBreak
    {
      $$ = $1
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

dialog
  : role LineBreak words
    {
      $3.forEach(word => {
        word.roleName = $1
      })
      $$ = $3
    }
  | dialog LineBreak words
    {
      $3.forEach(word => {
        word.roleName = $1
      })
      $$ = $1.concat($3)
    }
  ;

role
  : ROLE
    {
      if ($1 === 'NARRATOR') {
        $$ = '<Narrator>'
      } else {
        $$ = $1.replace(/\<Role\>/g,'').replace(/\s*$/g, '')
      }
    }
  ;

// 对话句子
words
  : lineWords
    {
      // 如果对话文本长度超过120 则截断成多段对话
      const text = $1.text
      const textList = window.cutText(text)
      const wordList = []
      textList.forEach(t => {
        wordList.push({
          ...$1,
          text: t
        })
      })
      $$ = wordList
      // $$ = [$1]
    }
  | words lineWords
    {
      $$ = $1.concat($2)
    }
  ;

lineWords
  : WORDS LineBreak
    {
      $$ = {
        type: 2, // 表示普通对白
        text: $1.replace(/\'/g,'')
      }
    }
  | THOUGHT LineBreak
    {
      $$ = {
        type: 3, // 表示内心独白
        text: $1.replace(/^\(|\)$/g,'')
      }
    }
  | choice
    {
      $$ = $1
    }
  | dress
    {
      $$ = $1
    }
  | branch
    {
      $$ = $1
    }
  ;

branch
  : BRANCH_HEAD LineBreak options
    {
      $$ = {
        type: 6,
        text: $1.replace(/\<Branch\>/g,''),
        options: $3
      }
    }
  ;

dress
  : DRESS_HEAD LineBreak options
    {
      $$ = {
        type: 5,
        text: $1.replace(/\<Dress-up\>/g,''),
        options: $3
      }
    }
  ;


choice
  : CHOICE_HEAD LineBreak options
    {
      $$ = {
        type: 4,
        text: $1.replace(/\<Choice\>/g,''),
        options: $3
      }
    }
  ;

options
  : optionItem
    {
      $$ = [$1]
    }
  | options optionItem
    {
      $$ = $1.concat($2)
    }
  ;

optionItem
  : optionHead LineBreak
    {
      $$ = {
        optionText: $1,
        subPlotId: ''
      }
    }
  | optionHead LineBreak '{' LineBreak events '}' LineBreak
    {
      const plotId = window.functionRandom()
      const plot = {
        plotId,
        events: $5
      }
      window.subPlots.push(plot)
      $$ = {
        optionText: $1,
        subPlotId: plotId
      }
    }
  ;

optionHead
  : OPTION
    {
      $$ = $1.replace(/\<Option\>/g,'')
    }
  ;
  

// 换行结构
LineBreak
  : EOL
    {
    }
  | LineBreak  EOL
    {
    }
  ;

init
  :
    {
      window.subPlots = []
      // 定义ID随机数函数
      if (!window.functionRandom) {
        window.functionRandom = function () {
          let guid = '';
          for (let i = 1; i <= 32; i++) {
            guid += Math.floor(Math.random() * 16.0).toString(16);
            if ((i === 8) || (i === 12) || (i === 16) || (i === 20)) {
              guid += '-';
            }
          }
          return guid
        }
      }

      window.roleNameRecordObj = {}
      window.sceneNameRecordObj = {}
      if (!window.getEventsRoleAndSceneInfo) {
        window.getEventsRoleAndSceneInfo = function (events, roles, scenes) {
          events.forEach(event => {
            if (event.type === 1 && !sceneNameRecordObj[event.sceneName]) {
              scenes.push({
                name: event.sceneName
              })
              sceneNameRecordObj[event.sceneName] = true
            } else if (event.roleName && !roleNameRecordObj[event.roleName]) {
              roles.push({
                characterName: event.roleName
              })
              roleNameRecordObj[event.roleName] = true
            }
          })
        }
      }

      if (!window.calculateTextLength) {
        window.calculateTextLength = function (str) {
          let count = 0
          for (let i = 0; i < str.length; i++) {
            if (str.charCodeAt(i) > 127 || str.charCodeAt(i) === 94) {
              // 中文
              count += 4
            } else {
              // 英文
              count += 2
            }
          }
          return Math.ceil(count / 2)
        }
      }

      if (!window.getStringByLength) {
        window.getStringByLength = function (str, len) {
          let strlen = 0
          let s = ''
          for (let i = 0; i < str.length; i++) {
              if (str.charCodeAt(i) > 128) {
                  strlen += 2
              } else {
                  strlen++
              }
              s += str.charAt(i)
              if (strlen >= len) {
                  return s
              }  
          }  
          return s 
        }
      }

      if (!window.cutText) {
        window.cutText = function (text) {
          const words = []
          const textLength = window.calculateTextLength(text)
          if (textLength > 120) {
            const newText = window.getStringByLength(text, 120)
            words.push(newText)
            text = text.replace(newText, '')
            if (text) {
              words.push(...window.cutText(text))
            }
          } else {
            words.push(text)
          }
          return words
        }
      }

      $$ = null
    }
  ;
