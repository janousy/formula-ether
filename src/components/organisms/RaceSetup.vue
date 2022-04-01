<template>
    <div>
        <RaceHeader :total-bet-sum="totalBetSum"/>
        <div v-show="getRaceStatus === 0" class="teamsWrapper">
            <TeamTile
                    v-for="(team, index) in getTeams"
                    :key="`team${index}`"
                    :team="team"
                    :total-amounts="totalAmountPerTeam"
                    :total-bet-sum="totalBetSum"
                    :qualifying-results="qualifyingResults"
                    :index-number="index"
                    @click.native="clickOnTeam(index)"
            />
            <div
                    v-for="(item) in this.fillingElements"
                    :key="`fillingElement${item}`"
                    class="filling-empty-space-containers">
            </div>
            <betting-modal :team="getTeams[selectedTeam]"/>
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
        getTotalAmount,
        getWinningPlayers,
        getWinningTeam
    } from "../../services/etherService";
    import {etherConversions} from "../../consts/etherConversions.const";
    import {pollingTimes} from "../../consts/pollingTimes.const";

    export default {
        name: 'RaceSetup',
        components: {RaceEnding, RaceWaiting, BettingModal, TeamTile, RaceHeader},
        computed: {
            ...mapState('data', {
                betIsPlaced: (state) => state.betIsPlaced,
                raceStatus: (state) => state.raceStatus,
                signer: (state) => state.signer,
                totalAmountPerTeam: (state) => state.totalAmountPerTeam,
                totalBetSum: (state) => state.totalBetSum,
                qualifyingResults: (state) => state.qualifyingResults,
                timeElapsed: (state) => state.timeElapsed,
                address: (state) => state.address,
                playersParticipatedInRace: (state) => state.playersParticipatedInRace,
            }),
            getTeams() {
                return f1MetaData.teams
            },
            getRaceStatus() {
                return this.raceStatus;
            }
        },
        data: () => {
            return {
                fillingElements: [0, 1, 2, 3],
                selectedTeam: 0,
            }
        },
        mounted() {
            this.getQualifyingResults();
            setInterval(() => {
                if (this.getRaceStatus !== 2) {
                    console.log('Polled get Total Amounts');
                    this.getTotalBetAmount();
                }
            }, pollingTimes.totalAmounts);
            setInterval(() => {
                if (this.getRaceStatus === 2 && this.playersParticipatedInRace){
                    console.log('Poll for Winners');
                    this.getWinners();
                }
            }, pollingTimes.winners);
            setInterval(() => {
                if (this.qualifyingResults.length === 0) {
                    console.log('Poll for qualy results');
                    this.getQualifyingResults();
                }
            })
        },
        methods: {
            clickOnTeam(teamIndex) {
                this.selectedTeam = teamIndex;
                this.$bvModal.show('BettingModal');
            },
            async getTotalBetAmount() {
                const totalAmountsInHex = await getTotalAmount(this.signer);
                const totalAmountPerTeam = [];
                let totalSum = 0;

                if (totalAmountsInHex) {
                    totalAmountsInHex.forEach((num) => {
                        const parsedInt = parseInt(num._hex, 16) / etherConversions.toMetamask;
                        totalSum = totalSum + parsedInt;
                        totalAmountPerTeam.push(parsedInt)
                    })
                }
                this.$store.commit('data/setTotalAmountPerTeam', totalAmountPerTeam);
                this.$store.commit('data/setTotalBetSum', totalSum);
            },
            async getQualifyingResults() {
                // TODO fix function to get better results
                const mockData = ['alfa_romeo', 'redbull', 'aston_martin', 'alpha_tauri', 'mercedes', 'alpine', 'williams', 'mclaren', 'haas', 'ferrari'];
                this.$store.commit('data/setQualifyingResults', mockData);
            },
            async startRace() {
                const allPlayers = await getAllPlayers(this.signer);

                if (allPlayers.length === 0){
                    console.log('No players participated in the race');
                    return;
                }
                await this.$store.commit('data/setPlayersParticipatedInRace', true);

                if (allPlayers[0] === this.address){
                    console.log('addresses match');
                    console.log('Starting race in contract');
                    await distributePrices(this.signer);
                    console.log('Race was executed on contract');
                }

                this.getWinners()

            },
            async getWinners() {
                // TODO fix function to get better results
                const winningPlayers = await getWinningPlayers(this.signer);
                const winningTeam = await getWinningTeam(this.signer);

                if (winningPlayers) {
                    this.$store.commit('data/setRaceWinningPlayers', winningPlayers);
                }
                if (winningTeam) {
                    this.$store.commit('data/setRaceWinningTeam', winningTeam);

                }
            }
        },
        watch: {
            signer() {
                this.getTotalBetAmount()
            },
            timeElapsed(newVal) {
                if (newVal) {
                    this.startRace();
                }
            }
        }
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
