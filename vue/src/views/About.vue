<template>
  <div class="home">
    about
  </div>
</template>

<script>
/* eslint-disable*/
// import test1 from '@/assets/test/test1.js'
// import test2 from '@/assets/test/test2.js'
// import test2txt from '@/assets/test/test2txt.js'
// import story_editor_2 from '@/assets/story-parser-generator/story_editor_2.js'
// import text from '@/assets/story-parser-generator/text.js'

// import storyParser2 from './test/storyParser_2'
import storyParser2 from './test2/storyParser_2'
// import text from './test/text.js'
import text from './test/text3ss.js'
export default {
  mounted () {
    // console.log("story_editor_2",story_editor_2)
      // console.log("test1",test1.parse('happy joy'))
      // console.log("test2",test2.parse(test2txt))
      // console.log("story_editor_2".story_editor_2(text))
this.test()
  },
  methods:{
        test() {
      const aa = storyParser2.parse(text)
      console.log('aa', aa)
    }
  }
}
</script>
