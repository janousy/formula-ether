<template>
  <div class="teamTile">
    <div class="textWrapper">
      <div class="teamName">{{ team.displayName }}</div>
      <div class="quote">Factor = {{ getQuote }}</div>
      <div class="quote">Qualifying = {{ getQualifyingPosition }}</div>
    </div>
    <div class="imageWrapper">
      <img class="teamIcon" :src="getTeamIcon" alt="TeamIcon">
    </div>
  </div>
</template>

<script>

import f1MetaData from "@/consts/f1-meta";

export default {
  name: 'TeamTile',
  props: {
    team: {
      type: Object,
      required: true
    },
    totalAmountPerTeam: {
      type: Array,
      required: true,
    },
    totalBetSum: {
      type: Number,
      required: true,
    },
    indexNumber: {
      type: Number,
      required: true,
    }
  },
  computed: {
    getTeamIcon() {
      return require(`@/assets/images/teams/${this.team.key}.jpg`);
    },
    getQuote() {
      if (this.totalBetSum === 0) {
        return 0;
      }
      const index = f1MetaData.teams.indexOf(this.team);
      return (this.totalAmountPerTeam[index] / this.totalBetSum).toFixed(2);
    },
    getQualifyingPosition() {
      let textAdding = '';
      switch (this.indexNumber) {
        case 0:
          textAdding = 'st';
          break;
        case 1:
          textAdding = 'nd';
          break;
        default:
          textAdding = 'th';
          break;
      }
      return `${this.indexNumber + 1}${textAdding}`
    }
  },
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
      width: 200px;
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
