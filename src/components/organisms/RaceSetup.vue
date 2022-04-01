<template>
    <div>
        <RaceHeader/>
        <div v-if="getRaceStatus === 1" class="teamsWrapper">
            <TeamTile
                v-for="(team, index) in getTeams"
                :key="`team${index}`"
                :team="team"
                @click.native="clickOnTeam(index)"
            />
            <div
                v-for="(item) in this.fillingElements"
                :key="`fillingElement${item}`"
                class="filling-empty-space-containers">
            </div>
            <betting-modal :team="getTeams[selectedTeam]"/>
        </div>
        <RaceWaiting v-if="getRaceStatus === 1"/>
        <RaceEnding v-if="getRaceStatus === 0"/>
    </div>
</template>

<script>
import RaceHeader from "../molecules/RaceHeader";
import TeamTile from "../molecules/TeamTile";
import BettingModal from "./BettingModal";
import { mapState } from 'vuex'
import RaceWaiting from "../molecules/RaceWaiting";
import f1MetaData from "../../consts/f1-meta";
import RaceEnding from "../molecules/RaceEnding";

export default {
  name: 'RaceSetup',
  components: {RaceEnding, RaceWaiting, BettingModal, TeamTile, RaceHeader },
  computed: {
    ...mapState('data', {
      betIsPlaced: (state) => state.betIsPlaced,
      raceStatus: (state) => state.raceStatus,
    }),
    getTeams () {
      return f1MetaData.teams
    },
    getRaceStatus() {
        return this.raceStatus;
    }
  },
  data: () => {
    return {
      fillingElements: [0, 1, 2, 3],
      selectedTeam: 0
    }
  },
  methods: {
    clickOnTeam (teamIndex) {
      this.selectedTeam = teamIndex;
      this.$bvModal.show('BettingModal');
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
