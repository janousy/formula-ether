<template>
  <div>
    <RaceHeader :total-bet-sum="totalBetSum"/>
    <div v-show="getRaceStatus === 0" class="teamsWrapper">
      <TeamTile
          v-for="(team, index) in qualifyingResults"
          :key="`team${index}`"
          :team="getTeam(team)"
          :total-amounts="totalAmountPerTeam"
          :total-bet-sum="totalBetSum"
          :index-number="index"
          @click.native="clickOnTeam(team)"
      />
      <div
          v-for="(item) in this.fillingElements"
          :key="`fillingElement${item}`"
          class="filling-empty-space-containers">
      </div>
      <betting-modal ref="bettingModal" :team="getTeam(selectedTeam)"/>
    </div>
    <RaceWaiting v-show="getRaceStatus === 1"/>
    <RaceEnding v-show="getRaceStatus === 2"/>
  </div>
</template>

<script>
import RaceHeader from "../molecules/RaceHeader";
import TeamTile from "../molecules/TeamTile";
import BettingModal from "./BettingModal";
import {mapState} from 'vuex'
import RaceWaiting from "../molecules/RaceWaiting";
import f1MetaData from "../../consts/f1-meta";
import RaceEnding from "../molecules/RaceEnding";
import {
  distributePrices,
  getAllPlayers,
  getRaceCounter,
  getTotalAmount,
  getWinningAmounts,
  getWinningPlayers,
  getWinningTeam
} from "@/services/etherService";
import {pollingTimes} from "@/consts/pollingTimes.const";
import {qualifyingSetup} from "@/consts/qualifyingSetup.const";
import countDownTimings from "@/consts/countdown.const";
import addressesConst from "@/consts/addresses.const";

export default {
  name: 'RaceSetup',
  components: {RaceEnding, RaceWaiting, BettingModal, TeamTile, RaceHeader},
  data: () => {
    return {
      fillingElements: [0, 1, 2, 3],
      selectedTeam: 'mercedes',
      initialRaceCounter: 0,
    }
  },
  computed: {
    ...mapState('timerStore', {
      raceStatus: (state) => state.raceStatus,
      timeElapsed: (state) => state.timeElapsed,
    }),
    ...mapState('etherStore', {
      signer: (state) => state.signer,
      address: (state) => state.address,
    }),
    ...mapState('raceStore', {
      betIsPlaced: (state) => state.betIsPlaced,
      playersParticipatedInRace: (state) => state.playersParticipatedInRace,
      qualifyingResults: (state) => state.qualifyingResults,
      totalAmountPerTeam: (state) => state.totalAmountPerTeam,
      totalBetSum: (state) => state.totalBetSum,
      raceCounter: (state) => state.raceCounter,
    }),
    getRaceStatus() {
      return this.raceStatus;
    }
  },
  watch: {
    signer() {
      this.getTotalBetAmount();
      this.getInitialRaceCounter();
    },
    timeElapsed(newVal) {
      if (newVal) {
        this.startRace();
      }
      if (!newVal) {
        this.simulateQualifyingResults();
      }
    },
    raceCounter() {
      this.getWinners()
    },
  },
  beforeMount() {
    this.simulateQualifyingResults();
    setInterval(() => {
      if (this.getRaceStatus !== 2) {
        console.log('Polled get Total Amounts');
        this.getTotalBetAmount();
      }
    }, pollingTimes.totalAmounts);
    setInterval(() => {
      if (this.getRaceStatus === 2 && this.playersParticipatedInRace) {
        console.log('Poll for raceCounter');
        this.getRaceCounter();
      }
    }, pollingTimes.winners);
  },
  methods: {
    async getTotalBetAmount() {
      const totalAmountsInHex = await getTotalAmount(this.signer);
      const totalAmountPerTeam = [];
      let totalSum = 0;

      if (totalAmountsInHex) {
        totalAmountsInHex.forEach((num) => {
          const parsedInt = parseInt(num._hex, 16);
          totalSum = totalSum + parsedInt;
          totalAmountPerTeam.push(parsedInt)
        })
      }
      this.$store.commit('raceStore/setTotalAmountPerTeam', totalAmountPerTeam);
      this.$store.commit('raceStore/setTotalBetSum', totalSum);
    },
    async startRace() {
      console.log('Start race was executed');
      const allPlayers = await getAllPlayers(this.signer);

      // do nothing if no players participated
      if (!allPlayers || allPlayers.length === 0) {
        console.log('No players participated in the race');
        this.$store.commit('timerStore/setRaceStatus', 2);
        return;
      }

      console.log('The following players participated in the race: ', allPlayers)
      await this.$store.commit('raceStore/setPlayersParticipatedInRace', true);

      // check if admin
      // if yes, execute distributePrices and show admin info, afterwards switch screen
      // if no, wait predefined time and then switch screen
      if (allPlayers[0] === this.address) {
        console.log('Addresses match');
        console.log('Starting race in contract');

        this.$bvModal.show('AdminModal')
        await distributePrices(this.signer);
        console.log('Race was executed on contract');

        this.$store.commit('timerStore/setRaceStatus', 2);
        this.$bvModal.hide('AdminModal');
      } else {
        setTimeout(() => {
          console.log('No admin, adding extra time before change screen')
          this.$store.commit('timerStore/setRaceStatus', 2);
        }, countDownTimings.waitTimeForNonAdmins)
      }
    },
    async getWinners() {
      const winningPlayers = await getWinningPlayers(this.signer);
      const winningAmounts = await getWinningAmounts(this.signer);
      const filteredWinningPlayers = winningPlayers.filter(val => val !== addressesConst.emptyAddress)
      const filteredWinningAmounts = winningPlayers.filter(val => val !== 0)
      const winningTeam = await getWinningTeam(this.signer);

      if (winningPlayers) {
        console.log(winningPlayers);
        this.$store.commit('raceStore/setRaceWinningPlayers', filteredWinningPlayers);
      }
      if (winningAmounts) {
        console.log(winningAmounts)
        this.$store.commit('raceStore/setRaceWinningAmounts', filteredWinningAmounts);
      }
      if (winningTeam) {
        console.log(winningTeam)
        this.$store.commit('raceStore/setRaceWinningTeam', winningTeam);
      }
    },
    async getRaceCounter() {
      const raceCounter = await getRaceCounter(this.signer);
      const parsedRaceCounter = parseInt(raceCounter._hex, 16);
      if (parsedRaceCounter !== this.initialRaceCounter) {
        console.log('Race Counter updated to ', parsedRaceCounter);
        this.$store.commit('raceStore/setRaceCounter', parsedRaceCounter);
        this.initialRaceCounter = parsedRaceCounter;
      }
    },
    async getInitialRaceCounter() {
      const initRaceCounter = await getRaceCounter(this.signer);
      const parsedRaceCounter = parseInt(initRaceCounter._hex, 16);
      if (parsedRaceCounter >= 0) {
        console.log('Initial Race Counter set to ', parsedRaceCounter)
        this.initialRaceCounter = parsedRaceCounter;
      }
      else {
        console.warn('No initial race counter is set');
      }
    },
    clickOnTeam(team) {
      this.selectedTeam = team;
      // reset the amount which is shown
      this.$refs.bettingModal.resetInputForm()
      // show the modal
      this.$bvModal.show('BettingModal');
    },
    getTeam(teamName) {
      return f1MetaData.teams.find(team => team.key === teamName)
    },
    simulateQualifyingResults() {
      console.log('Qualifying results were simulated')
      let qualifyingResults = [];
      qualifyingResults = qualifyingResults.concat(this.shuffleArray(qualifyingSetup.frontRows));
      qualifyingResults = qualifyingResults.concat(this.shuffleArray(qualifyingSetup.middleRows));
      qualifyingResults = qualifyingResults.concat(this.shuffleArray(qualifyingSetup.backRows));

      this.$store.commit('raceStore/setQualifyingResults', qualifyingResults);
    },
    shuffleArray(array) {
      for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        const temp = array[i];
        array[i] = array[j];
        array[j] = temp;
      }
      return array;
    }
  },
}
</script>

<style lang="scss" scoped>
@import "src/styles/fonts.scss";

.teamsWrapper {
  padding: 40px 40px 0 40px;
  display: flex;
  justify-content: space-between;
  flex-flow: row wrap;
  height: 100%;
}

.filling-empty-space-containers {
  width: 300px;
  height: 0;
  margin: 10px;
}

</style>
