<template>
  <div class="hello">

     <div class="message-container">
  
    </div>

  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  props: {
    msg: String
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

      /* 消息框样式 */
      .message-container {
        width: 260px;
        margin: 20px;
        padding: 10px;
        border-style: solid;
        border-width: 1px;
        border-radius: 0.125rem;
        border-color: rgb(154, 223, 223);
        background-color: white;
        filter: drop-shadow(rgba(0, 0, 0, 0.1) 0px 1px 2px)
         drop-shadow(rgba(0, 0, 0, 0.06) 0px 1px 1px);

          border-width: 7px;
          border-style: solid;
          border-color: transparent #9ADFDF transparent transparent;


      }
 
      /* 通过消息框伪元素 ::before 和 ::after 实现三角样式定义 */
      /* .message-container::before{
          content: "";
          position: absolute;
          border-width: 7px;
          border-style: solid;
      } */
 
      /* 消息框伪元素 ::before 设置底部三角颜色为绿色 */
      /* .message-container::before {
          left: -0px;
          border-color: transparent #9ADFDF transparent transparent;
      }
  */
     
     



</style>
