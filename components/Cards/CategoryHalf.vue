<template>
  <div
    :class="[ type === 'top-over' ? 'top-over' : 'bottom-over' ]"
    :style="{ 'background-color': '#' + background }"
    class="category"
  >
    <img :src="img" :alt="title" />
    <span class="property">
      <span class="title-main use-text-title2">
        {{ title }}
      </span>
      <span class="total use-text-paragraph">
        {{ total }}
        &nbsp;Items
      </span>
      <hidden point="xsDown">
        <v-btn
          block
          large
          outlined
          color="secondary"
          class="button"
        >
          See Detail
        </v-btn>
      </hidden>
    </span>
  </div>
</template>

<style lang="scss" scoped>
@import './card-style';
</style>

<script>
import Hidden from '../Hidden'

export default {
  components: {
    Hidden
  },
  props: {
    img: {
      type: String,
      required: true
    },
    title: {
      type: String,
      required: true
    },
    background: {
      type: String,
      required: true
    },
    total: {
      type: [String, Number],
      required: true
    },
    type: {
      type: String,
      required: true
    }
  }
}
</script>
