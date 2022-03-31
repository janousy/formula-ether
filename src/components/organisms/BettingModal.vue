<template>
    <b-modal id="BettingModal" size="lg" hide-footer centered>
        <template #modal-header="{ close }">
            <div class="header">
                <div>Bet on your team</div>
                <div class="closeModalWrapper" @click="close()">
                    <i class="bi-x closingX"/>
                </div>
            </div>
        </template>
        <template #default>
            <div class="mainContent">
                <b-row>
                    <driver-information
                            :driver="team.drivers[0]"
                    >
                    </driver-information>
                    <driver-information
                            :driver="team.drivers[1]"
                    >
                    </driver-information>
                    <img class="teamLogo" :src="getTeamLogo" alt="TeamLogo">
                </b-row>
                <b-row class="secondRow" align-v="center">
                    <b-form-input
                        class="betInput"
                        type="number"
                        v-model="betAmount"
                        :state="isNumberValid"
                        placeholder="amount"
                    />
                    <b-button class="betButton" :disabled="isButtonDisabled" @click="betIsPlaced()">BET</b-button>
                </b-row>
            </div>
        </template>
    </b-modal>
</template>

<script>
import DriverInformation from '@/components/atoms/DriverInformation.vue'

export default {
  /* eslint-disable semi */

  name: 'BettingModal',
  components: { DriverInformation },
  props: {
    team: {
      type: Object,
      required: true
    }
  },
  computed: {
    getTeamLogo () {
      return `@/assets/images/teams/${this.team.key}.jpg`;
    },
    isNumberValid () {
      if (this.betAmount === null) {
        return null
      }
      return this.betAmount > 0
    },
    isButtonDisabled () {
      return this.betAmount <= 0 || this.betAmount === null
    }
  },
  data: () => {
    return {
      betAmount: null
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
        height: 400px;
        color: white;
        white-space: pre-line;
        position: relative;
        .teamLogo {
            width: 200px;
            object-fit: contain;
            position: absolute;
            right: 0;
        }
        .secondRow {
            flex-direction: column;
            .betButton {
                font-family: F1-Bold;
                font-size: 25px;
                width: 200px;
            }
            .betInput {
                font-family: F1-Bold;
                font-size: 25px;
                width: 200px;
                margin-bottom: 20px;
                margin-top: 20px;
            }
        }
    }

</style>