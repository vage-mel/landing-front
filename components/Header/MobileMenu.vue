<template>
  <div class="mobile-nav paper-nav">
    <div
      :class="{ 'menu-open': open }"
      class="menu"
    >
      <v-list
        dense
        tag="nav"
      >
        <v-list-item v-if="loaded && navMenu.length"
          v-for="(item, index) in navMenu"
          :key="index"
          :href="'#' + item.link"
          link
          :style="{ animationDuration: index * 0.15 + 's' }"
        >
          <v-list-item-content>
            <v-list-item-title class="menu-list">
              {{ item.name }}
            </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </div>
  </div>
</template>

<style scoped lang="scss">
@import './header-style';
</style>

<script>
// import navMenu from './menu'
import link from '~/static/text/link'
import axios from 'axios'

export default {
  data() {
    return {
      link: link,
      navMenu: [],
      loaded: false
    }
  },
  mounted() {
    axios.get(`http://127.0.0.1:8000/api/landing/menu/`)
    .then((response) => {
      this.navMenu = response.data
    })
    .catch((e) => {
      console.log(e)
    })
    .finally(() => {
      this.loaded = true
    })
  },
  props: {
    open: {
      type: Boolean,
      default: false
    }
  }
}
</script>
