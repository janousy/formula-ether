<template>
  <div class="winner">
    <span class="address">{{ address }}:</span>
    <span class="amount">{{ amount }} Ether</span>
  </div>
</template>

<script>
export default {
  name: 'WinnerRow',
  props: {
    address: {
      type: String,
      required: true
    },
    amount: {
      type: String,
      required: true
    }
  }
}
</script>

<style lang="scss" scoped>

.winner {
  margin-bottom: 20px;
  .amount {
    margin-left: 20px;
    word-break: keep-all;
  }
  .address {
    word-break: break-word;
  }
}

</style>
