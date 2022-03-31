<template>
    <div class="teamTile">
        <div class="textWrapper">
            <div class="teamName">{{team.displayName}}</div>
            <div class="quote">Quote = 0</div>
        </div>
        <div class="imageWrapper">
            <img class="teamIcon" :src="getTeamIcon" alt="TeamIcon">
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
      return require(`@/assets/images/teams/${this.team.key}.jpg`);
    }
  },
  methods: {
  }
}
</script>

<style lang="scss" scoped>
    @import "src/styles/fonts.scss";

    .teamTile {
        width: 300px;
        height: 300px;
        color: white;
        border: solid 4px #6c757d;
        border-radius: 5px;
        margin: 10px;
        cursor: pointer;
        padding: 10px 10px 10px 10px;
        position: relative;
        display: flex;
        flex-flow: column;
        justify-content: space-between;
        .imageWrapper {
            height: 150px;
            display: flex;
            justify-content: center;
            .teamIcon {
                width:200px;
                object-fit: contain;
            }
        }
        .teamName {
            font-family: F1-Bold;
            font-size: 30px;
        }
        .quote {
            font-family: F1-Regular;
            font-size: 25px;
        }
    }
</style>
