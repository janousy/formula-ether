<template>
    <div class="teamTile">
        <div class="generalInfoWrapper">
            <img class="teamIcon" :src="getTeamIcon" alt="TeamIcon">
            <div>{{team.displayName}}</div>
            <div>Quote = 0</div></div>
        <div class="driverInfoWrapper">
            <div>{{team.drivers[0].displayName}}</div>
            <div>{{team.drivers[1].displayName}}</div>
            <img class="driverIcon" :src="getDriverIcon(0)" alt="Driver0">
            <img class="driverIcon" :src="getDriverIcon(1)" alt="Driver1">
        </div>
    </div>
</template>

<script>

export default {
  /* eslint-disable semi */

  name: 'TeamTile',
  props: {
    team: {
      type: Object,
      required: true
    }
  },
  computed: {
    getTeamIcon () {
      return `/src/assets/images/teams/${this.team.key}.jpg`;
    }
  },
  methods: {
    getDriverIcon (driverNumber) {
      return `/src/assets/images/drivers/${this.team.drivers[driverNumber].key}.png`;
    }
  }
}
</script>

<style lang="scss" scoped>
    @import "src/styles/fonts.scss";

    .teamTile {
        width: 300px;
        height: 300px;

        color: white;
        border: solid 2px white;
        text-align: center;
        margin: 10px;
        cursor: pointer;
        .generalInfoWrapper {
            font-family: F1-Regular;
            font-size: 25px;
            display: flex;
            .teamIcon {
                width:100px;
                object-fit: contain;
            }
        }
        .driverInfoWrapper {
            font-family: F1-Regular;
            font-size: 25px;
            .driverIcon {
                width: 60px;
            }
        }
    }
</style>
