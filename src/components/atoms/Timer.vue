<template>
    <div class="timerWrapper">
        <div class="nextRaceWrapper">
            <div class="nextRaceText">
                {{getNextRaceText}}
            </div>
        </div>
        <div class="clockWrapper">
            <div>
                <p class="time" :class="timerLessThan1Min ? 'colorRed' : ''">{{getMinutes}}</p>
                <span class="unit">mins</span>
            </div>
            <div>
                <p class="time" :class="timerLessThan1Min ? 'colorRed' : ''">{{getSeconds}}</p>
                <span class="unit">sec</span>
            </div>
        </div>
    </div>
</template>

<script>
import headerTexts from "../../consts/headerTexts.const";
import countDownTimings from "../../consts/countdown.const";

export default {
  /* eslint-disable semi */
  // eslint-disable-next-line vue/multi-word-component-names
  name: 'Timer',
  components: {},
  computed: {
    getNextRaceText () {
      return headerTexts.raceHeaderTexts[0];
    },
    getSeconds () {
      return this.timerCount % 60;
    },
    getMinutes () {
      return Math.floor(this.timerCount / 60);
    },
    timerLessThan1Min () {
      return this.timerCount < 60;
    }
  },
  data: () => {
    return {
      timerCount: countDownTimings.countDownRunTime
    }
  },
  methods: {
    emitCountDownZero () {
      this.$emit('countDownIsZero');
      this.resetCounter()
    },
    resetCounter () {
      setTimeout(() => {
        this.timerCount = countDownTimings.countDownRunTime;
        this.$emit('resetCounter')
      }, countDownTimings.countDownResetTime)
    }

  },
  watch: {
    timerCount: {
      handler (remainingTime) {
        if (remainingTime > 0) {
          setTimeout(() => {
            this.timerCount--
          }, 1000)
        } else {
          this.emitCountDownZero()
        }
      },
      immediate: true // set to true to start counter right away
    }
  }

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
