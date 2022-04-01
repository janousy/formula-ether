<template>
    <div>
        <div class="winnersWrapper">
            <div class="winnerTitle">Winning Team: {{raceWinningTeam}}</div>
            <Winner
                    class="winners"
                    v-for="(winner, index) in getRaceWinners"
                    :key="index"
                    :address="winner"
                    :amount="getWinnersAmounts[index]"
            >
            </Winner>
        </div>
    </div>
</template>

<script>
import Winner from "../atoms/Winner";
import {mapState} from "vuex";
import f1MetaData from "../../consts/f1-meta";

export default {
    name: "RaceEnding",
    components: { Winner },
    props: {},
    computed: {
        ...mapState('data', {
            raceWinningTeam: (state) => state.raceWinningTeam,
            raceWinningPlayers: (state) => state.raceWinningPlayers,
        }),
        getRaceWinningTeam() {
            // TODO fix function to show display name
            return f1MetaData
        },
        getRaceWinners() {
            return this.raceWinningPlayers;
        },
        getWinnersAmounts() {
            return []
        },
    },
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
            width: 60%;
            display: flex;
            justify-content: space-between;
        }
    }

</style>