<template>
  <b-modal id="AdminModal" centered size="lg">
    <template #modal-header="{ close }">
      <div class="header">
        <div>Admin Selection</div>
        <div class="closeModalWrapper" @click="close()">
          <i class="bi-x closingX"/>
        </div>
      </div>
    </template>
    <template #default>
      <div class="mainContent">
        <span class="text1">{{ getAdminModalText1 }}</span>
        <span class="text2">{{ getAdminModalText2 }}</span>
      </div>
    </template>
    <template #modal-footer="{ close }">
      <div class="footer">
        <b-button @click="close()">
          OK
        </b-button>
      </div>
    </template>
  </b-modal>
</template>

<script>

import {texts} from "@/consts/generalTexts.consts";

export default {
  name: "AdminModal",
  computed: {
    getAdminModalText1() {
      return texts.adminSelection1
    },
    getAdminModalText2() {
      return texts.adminSelection2
    }
  },
  methods: {}
}
</script>

<style lang="scss" scoped>
@import "src/styles/fonts.scss";

.header {
  font-family: F1-Bold;
  font-size: 30px;
  color: white;
  width: 100%;
  position: relative;

  .closeModalWrapper {
    height: 100%;
    text-align: center;
    width: 40px;
    position: absolute;
    top: 0;
    right: 0;
    margin-top: -14px;
    cursor: pointer;

    .closingX {
      font-size: 45px;
    }
  }
}

.mainContent {
  font-size: 20px;
  color: white;
  white-space: pre-line;
  display: flex;
  flex-flow: column;
  .text1 {
    font-family: F1-Regular;
  }
  .text2 {
    margin-top: 30px;
    font-family: F1-Bold;
  }
}

.footer {
  font-family: F1-Bold;
  font-size: 20px;
}

</style>