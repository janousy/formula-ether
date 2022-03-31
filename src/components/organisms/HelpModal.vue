<template>
    <b-modal id="HelpModal" size="xl" hide-footer>
        <template #modal-header="{ close }">
            <div class="header">
                <div>How the racing works</div>
                <div class="closeModalWrapper" @click="close()">
                    <i class="bi-x closingX"/>
                </div>
            </div>
        </template>
        <template #default>
            <div class="mainContent">
                {{getHelpText}}
            </div>
        </template>
    </b-modal>
</template>

<script>
import { helpModalText } from '@/consts/helpModalText.const'

export default {
  /* eslint-disable semi */

  name: 'HelpModal',
  computed: {
    getHelpText () {
      return helpModalText
    }
  },
  methods: {
  }
}
</script>

<style lang="scss" scoped>
    @import "src/styles/fonts.scss";

    .header{
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
            .closingX{
                font-size: 45px;
            }
        }
    }
    .mainContent{
        font-family: F1-Regular;
        font-size: 20px;
        color: white;
        white-space: pre-line;
    }

</style>
