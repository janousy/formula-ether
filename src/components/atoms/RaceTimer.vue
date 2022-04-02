<template>
  <div class="timerWrapper">
    <div class="nextRaceWrapper">
      <div class="nextRaceText">
        {{ getNextRaceText }}
      </div>
    </div>
    <div class="clockWrapper">
      <div>
        <p class="time" :class="timerLessThan1Min ? 'colorRed' : ''">{{ getMinutes }}</p>
        <span class="unit">mins</span>
      </div>
      <div>
        <p class="time" :class="timerLessThan1Min ? 'colorRed' : ''">{{ getSeconds }}</p>
        <span class="unit">sec</span>
      </div>
    </div>
  </div>
</template>

<script>
import headerTexts from "../../consts/headerTexts.const";
import countDownTimings from "../../consts/countdown.const";
import {mapState} from "vuex";

export default {
  name: 'RaceTimer',
  data: () => {
    return {
      timerCount: 10 * 60,
    }
  },
  computed: {
    ...mapState('timerStore', {
      timeElapsed: (state) => state.timeElapsed,
      timerLessThan30s: (state) => state.timerLessThan30s,
    }),
    ...mapState('raceStore', {
      playersParticipatedInRace: (state) => state.playersParticipatedInRace,
    }),
    getNextRaceText() {
      return headerTexts.raceHeaderTexts[0];
    },
    getSeconds() {
      return this.timerCount % 60;
    },
    getMinutes() {
      return Math.floor(this.timerCount / 60);
    },
    timerLessThan1Min() {
      return this.timerCount < 60;
    },
  },
  watch: {
    timerCount: {
      handler(remainingTime) {
        if (remainingTime === undefined || isNaN(remainingTime)) {
          return
        }
        if (remainingTime > 0) {
          setTimeout(() => {
            this.timerCount--
          }, 1000)
        } else {
          this.timerElapsed()
        }
        if (remainingTime < 30 && !this.timerLessThan30s) {
          this.$store.commit('timerStore/setTimerLessThan30s', true)
        }
      },
    },
    timeElapsed(newVal) {
      if (newVal) {
        console.log('Start timer reset with timeout');
        setTimeout(() => {
          this.resetGame();
        }, countDownTimings.countDownResetTime)
      }
    }
  },
  beforeMount() {
    this.calculateTimer();
  },
  methods: {
    async calculateTimer() {
      let time = '';

      console.log('Fetch time from api');
      await fetch('http://worldtimeapi.org/api/timezone/Europe/Zurich')
          .then(response => response.json())
          .then((data) => time = data.unixtime)
          .catch(err => console.warn(err));

      if (!time) {
        time = Math.floor(new Date().getTime() / 1000);
      }
      this.timerCount = countDownTimings.timeUntilRaceStarts - time % countDownTimings.timeUntilRaceStarts;
    },
    async timerElapsed() {
      this.$store.commit('timerStore/setTimeElapsed', true);
    },
    async resetGame() {
      console.log('Reset game');
      this.$emit('resetCounter');
      this.$store.commit('timerStore/setTimeElapsed', false);
      this.$store.commit('timerStore/setTimerLessThan30s', false);
      this.$store.commit('timerStore/setRaceStatus', 0);
      this.$store.commit('raceStore/setBetIsPlaced', false);
      this.$store.commit('raceStore/setRaceWinningTeam', '');
      this.$store.commit('raceStore/setRaceWinningPlayers', []);
      this.$store.commit('raceStore/setTotalAmountPerTeam', []);
      this.$store.commit('raceStore/setTotalBetSum', 0);
      this.$store.commit('raceStore/setQualifyingResults', []);
      this.$store.commit('raceStore/setPlayersParticipatedInRace', false);

      await this.calculateTimer();
    }
  },
}
</script>

<style lang="scss" scoped>
@import "src/styles/fonts.scss";

.timerWrapper {
  background-color: #1f1f27;
  width: 200px;
  height: 120px;
  border: solid;
  border-radius: 10px;
  display: flex;
  flex-direction: column;
  align-items: center;

  .nextRaceWrapper {
    border: solid;
    border-radius: 10px;
    background-color: #38383f;
    width: 150px;
    margin-top: 5px;

    .nextRaceText {
      color: white;
      font-family: F1-Regular;
      text-align: center;
    }
  }

  .clockWrapper {
    color: white;
    margin-top: 10px;
    display: flex;
    justify-content: space-around;
    text-align: center;
    width: 80%;

    .time {
      font-family: F1-Bold;
      font-size: 25px;
      margin-bottom: 0;
      width: 40px;
      text-align: center;

      &.colorRed {
        color: #e10600;
      }
    }

    .unit {
      font-family: F1-Regular;
      font-size: 15px;
    }
  }
}

</style>
