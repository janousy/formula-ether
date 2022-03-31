<template>
    <div class="driverInformationWrapper">
        <img class="driverNumber" :src="getDriverNumber" alt="DriverNr">
        <img class="driverImage" :src="getDriverImage" alt="Driver">
        <span class="driverName">{{driver.displayName}}</span>
    </div>
</template>

<script>
export default {
  /* eslint-disable semi */

  name: 'DriverInformation',
  props: {
    driver: {
      type: Object,
      required: true
    },
  },
  computed: {
    getDriverImage () {
      return `/src/assets/images/drivers/${this.driver.key}.png`;
    },
    getDriverNumber () {
      return `/src/assets/images/driverNumbers/${this.driver.id}.png`;
    }
  }
}
</script>

<style lang="scss" scoped>
    @import "src/styles/fonts.scss";

    .driverInformationWrapper {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
        .driverImage{
            width: 100px

        }
        .driverNumber{
            width: 100px;
            object-fit: contain;
        }
        .driverName {
            font-family: F1-Bold;
            font-size: 30px;
            padding-left: 20px;
        }
    ;
    }

</style>
