<template>
    <div>
        <span>{{address}}</span>
        <span class="amount">{{amount}} Ether</span>
    </div>
</template>

<script>
export default {
  // eslint-disable-next-line vue/multi-word-component-names
  name: 'Winner',
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
    .amount {
        margin-left: 20px;
    }

</style>
