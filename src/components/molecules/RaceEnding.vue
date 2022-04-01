<template>
    <div>
        <div class="videoWrapper">

        </div>
        <div class="winnersWrapper">
            <div class="winnerTitle">Winning Team: {{raceWinningTeam}}</div>
            <Winner
                    class="winners"
                    v-for="(winner, index) in winners"
                    :key="index"
                    :address="winner"
                    :amount="amounts[index]"
            >
            </Winner>
        </div>
    </div>
</template>

<script>
import Winner from "../atoms/Winner";
import {mapState} from "vuex";
import countDownTimings from "../../consts/countdown.const";

export default {
    name: "RaceEnding",
    components: { Winner },
    props: {},
    computed: {
        ...mapState('data', {
            raceWinningTeam: (state) => state.raceWinningTeam
        }),
    },
    data: () => {
        return {
            winners: [],
            timerCount: countDownTimings.countDownRunTime,
            amounts: ['1', '2', '3'],
            ...mapState('data', {
                winners: state => state.winners
            }),
        }
    }
}
</script>

<style lang="scss" scoped>
    @import "src/styles/fonts.scss";

    .winnersWrapper {
        width: 100%;
        margin-top: 200px;
        color: white;
        display: flex;
        flex-flow: column;
        align-items: center;

        .winnerTitle {
            font-family: F1-Bold;
            font-size: 50px;
            margin-bottom: 30px;
        }

        .winners {
            font-family: F1-Regular;
            font-size: 30px;
            width: 1200px;
            display: flex;
            justify-content: space-between;
        }
    }

</style>