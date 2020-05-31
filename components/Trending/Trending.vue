<template>
  <div class="root" v-if="loaded && items.length">
    <hidden point="xsDown">
      <div :class="item.css_class" v-for="item in items">
        <img :src="item.image" alt="trending" />
        <v-btn text class="overlay">
          <h5 class="headline">{{ item.headline }}</h5>
          <h3 v-if="item.display" class="display-2">{{ item.display }}</h3>
        </v-btn>
      </div>
    </hidden>
    <hidden v-if="loaded && items.length" point="smUp">
      <slick
        ref="slick"
        :options="slickOptions"
      >
        <div v-for="item in items">
          <div :class="item.css_class">
            <img :src="item.image" alt="trending" />
            <v-btn text class="overlay">
              <h5  class="headline">{{ item.headline }}</h5>
              <h3 v-if="item.display" class="display-2">{{ item.display }}</h3>
            </v-btn>
          </div>
        </div>
      </slick>
    </hidden>
  </div>
</template>

<style lang="scss" scoped>
@import './trending-stye.scss';
</style>

<script>
import imgAPI from '~/static/images/imgAPI'
import Hidden from '../Hidden'
import axios from 'axios'

export default {
  components: {
    Hidden,
    Slick: () => import('vue-slick')
  },
  data() {
    return {
      loaded: false,
      items: [],
      slickOptions: {
        dots: false,
        speed: 500,
        slidesToShow: 1,
        arrows: false,
        slidesToScroll: 1,
        autoplay: true,
        autoplaySpeed: 7000
      }
    }
  },
  mounted() {
    axios.get(`http://127.0.0.1:8000/api/landing/trending/`)
    .then((response) => {
      this.items = response.data
    })
    .catch((e) => {
      console.log(e)
    })
    .finally(() => {
      this.loaded = true
    })
  },
}
</script>
