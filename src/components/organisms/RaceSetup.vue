<template>
    <div>
        <RaceHeader/>
        <div v-if="!raceIsRunning" class="teamsWrapper">
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
        <div v-if="raceIsRunning">
            <RaceEnding/>
        </div>
    </div>
</template>

<script>
import RaceHeader from '@/components/molecules/RaceHeader.vue'
import TeamTile from '@/components/molecules/TeamTile.vue'
import BettingModal from '@/components/organisms/BettingModal.vue'
import { mapState } from 'vuex'
import f1MetaData from '@/consts/f1-meta'
import RaceEnding from '@/components/molecules/RaceEnding.vue';

export default {
  /* eslint-disable semi */

  name: 'RaceSetup',
  components: { RaceEnding, BettingModal, TeamTile, RaceHeader },
  computed: {
    ...mapState('data', {
      raceIsRunning: (state) => state.raceIsRunning
    }),
    getTeams () {
      return f1MetaData.teams
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
      // TODO either write into store what would be better i guess, or pass as props
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
