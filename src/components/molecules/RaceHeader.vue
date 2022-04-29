<template>
  <div class="raceHeader">
    <div v-if="internalRaceCounter !== -1" class="trackInfoWrapper">
      <div class="trackImageWrapper">
        <img class="trackImage" :src="getRaceImage" alt="Track Image">
      </div>
      <div class="textWrapper">
        <span>{{ getRaceName }}</span>
        <span>Total Bets: {{ getTotalBetAmount }} Ether</span>
      </div>
    </div>
    <div v-else class="trackInfoWrapper">
      <div class="textWrapper">
        <span>{{ getLoadingText }}</span>
      </div>
    </div>
    <Timer class="timer" @resetCounter="updateRaceLocation()"/>
  </div>
</template>

<script>
import raceLocations from "../../consts/raceLocations.const";
import Timer from "../atoms/RaceTimer";
import {mapState} from "vuex";
import {etherConversions} from "@/consts/etherConversions.const";
import {texts} from "@/consts/generalTexts.consts";

export default {
  name: 'RaceHeader',
  components: {Timer},
  props: {
    totalBetSum: {
      type: Number,
      required: true,
    },
    contractRaceCounter: {
      type: Number,
      required: true,
    }
  },
  data: () => {
    return {
      internalRaceCounter: -1,
    }
  },
  computed: {
    ...mapState('etherStore', {
      signer: (state) => state.signer,
    }),
    getRaceImage() {
      return require(`@/assets/images/raceTracks/${raceLocations.locations[this.internalRaceCounter]}.png`);
    },
    getRaceName() {
      return raceLocations.raceName[this.internalRaceCounter];
    },
    getTotalBetAmount() {
      return this.totalBetSum / etherConversions.weiToEth;
    },
    getLoadingText() {
      return texts.trackLoading;
    }
  },
  methods: {
    updateRaceLocation() {
      console.log('Race location is updated');
      this.internalRaceCounter = (this.contractRaceCounter) % raceLocations.raceName.length;
    },
    setInitialRaceCounter(parsedRaceCounter) {
      console.log("Set internal app header race counter to:", parsedRaceCounter % raceLocations.raceName.length);
      this.internalRaceCounter = parsedRaceCounter % raceLocations.raceName.length;
    },
  }
}
</script>

<style lang="scss" scoped>
@import "src/styles/fonts.scss";

.raceHeader {
  width: 100%;
  height: 150px;
  background-color: black;
  display: flex;
  align-items: center;
  justify-content: space-between;
  .trackInfoWrapper {
    padding-top: 15px;
    padding-left: 15px;
    display: flex;
    align-items: center;
    .trackImageWrapper {
      width: 120px;
      margin-right: 20px;
      .trackImage {
        width: 120px;
      }
    }
    .textWrapper {
      padding-left: 10px;
      display: flex;
      flex-flow: column;
      font-family: F1-Bold;
      color: white;
      font-size: 30px;
    }
  }
  .timer {
    margin-right: 40px;
  }
}

</style>
