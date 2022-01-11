<template>
  <div class="home"></div>
</template>

<script>
/* eslint-disable*/
import test3 from "@/assets/test/test3.js";
import test3s from "@/assets/test/test3s.js";
import test3Txt from "@/assets/test/test3Txt.js";

import test4 from "@/assets/test/test4.js";
import test4s from "@/assets/test/test4s.js";
import test4Txt from "@/assets/test/test4Txt.js";

import test5 from "@/assets/test/test5.js";
import test5Txt from "@/assets/test/test5Txt.js";

import test5s from "@/assets/test/test5s.js";
import test5sTxt from "@/assets/test/test5sTxt.js";

import test6 from "@/assets/test/test6.js";
import test6Txt from "@/assets/test/test6Txt.js";

import test7 from "@/assets/test/test7.js";
import test7Txt from "@/assets/test/test7Txt.js";

import test8 from "@/assets/test/test8.js";
import test8Txt from "@/assets/test/test8Txt.js";

import test9 from "@/assets/test/test9.js";
import test9Txt from "@/assets/test/test9Txt.js";
export default {
  mounted() {
    // console.log("test3",test3s.parse(test3Txt))
    // console.log("test4",test4.parse(`aaa\nbb\ncc\n`))
    // console.log("test4s", test4s.parse(test4Txt));
    // this.shiftFn();
    // this.test2()

    //  console.log("test5", test5.parse(test5Txt));
      // console.log("test5s", test5s.parse(test5sTxt));
      // console.log("test6", test6.parse(test6Txt));
      // console.log("test7", test7.parse(test7Txt));
          // console.log("test8", test8.parse(test8Txt));
            console.log("test9", test9.parse(test9Txt));
  },
  methods: {
    shiftFn() {
      //  var res = ''
      // const strs = ["aaa", "bbb", "ccc"];
      // strs.forEach(item => {
      //   var strItem = strs.shift();
      //   console.log("strItem",strItem)
      //    res+=strItem
      // })
      // console.log("res", res);

      var ress = ["aaa", "bbb", "ccc"];
      var arr = ress.reduce((prev,next) => {
        return prev+next
      },'')
      console.log("arr",arr)
    },
    test2(){
      const text = `aaa
bbb
ccc
`
      var textArr = text.split('\n')
      console.log("textArr",textArr)

      var res = textArr.reduce((prev,next) => {
        return prev+next
        console.log("prev",prev)
        console.log("next",next)
      },'')  
      console.log("res", res);
    }
  },
};
</script>
