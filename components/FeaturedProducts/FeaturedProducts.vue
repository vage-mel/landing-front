<template>
  <div class="root">
    <title-main align="center" primary="Featured" secondary="Products" />
    <div class="carousel-wrap">
      <v-btn class="nav prev" @click="slickPrev">
        <v-icon>mdi-arrow-left</v-icon>
      </v-btn>
      <v-btn class="nav next" @click="slickNext">
        <v-icon>mdi-arrow-right</v-icon>
      </v-btn>
      <div v-if="loaded">
        <slick
          ref="slider"
          :options="slickOptions"
        >
          <div
            v-for="(item, index) in dataProducts"
            :key="index"
            class="item"
          >
            <simple-thumb-card
              :title="item.title"
              :price="'$' + item.price"
              :img="item.img"
              :id="item.id"
            />
          </div>
        </slick>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import './featured-style.scss';
</style>

<script>
import imgAPI from '~/static/images/imgAPI';
import Title from '../Title';
import SimpleThumbCard from '../Cards/SimpleThumb';
import axios from 'axios'

// const dataProducts = [
//   {
//     title: 'Vivamus Sit Smet',
//     price: '$780.00',
//     img: imgAPI.fashion[17]
//   },
//   {
//     title: 'Vivamus Sit Smet',
//     price: '$780.00',
//     img: imgAPI.fashion[18]
//   },
//   {
//     title: 'Vivamus Sit Smet',
//     price: '$780.00',
//     img: imgAPI.fashion[19]
//   },
//   {
//     title: 'Vivamus Sit Smet',
//     price: '$780.00',
//     img: imgAPI.fashion[20]
//   },
//   {
//     title: 'Vivamus Sit Smet',
//     price: '$780.00',
//     img: imgAPI.fashion[21]
//   },
//   {
//     title: 'Vivamus Sit Smet',
//     price: '$780.00',
//     img: imgAPI.fashion[22]
//   },
//   {
//     title: 'Vivamus Sit Smet',
//     price: '$780.00',
//     img: imgAPI.fashion[23],
//   },
//   {
//     title: 'Vivamus Sit Smet',
//     price: '$780.00',
//     img: imgAPI.fashion[24]
//   },
//   {
//     title: 'Vivamus Sit Smet',
//     price: '$780.00',
//     img: imgAPI.fashion[25]
//   },
//   {
//     title: 'Vivamus Sit Smet',
//     price: '$780.00',
//     img: imgAPI.fashion[20]
//   },
//   {
//     title: 'Vivamus Sit Smet',
//     price: '$780.00',
//     img: imgAPI.fashion[22]
//   },
//   {
//     title: 'Vivamus Sit Smet',
//     price: '$780.00',
//     img: imgAPI.fashion[23]
//   },
// ];

export default {
  components: {
    'title-main': Title,
    SimpleThumbCard,
    Slick: () => import('vue-slick')
  },
  data() {
    return {
      loaded: false,
      dataProducts: [],
      slickOptions: {
        dots: true,
        speed: 500,
        slidesToShow: 6,
        arrows: false,
        slidesToScroll: 3,
        autoplay: true,
        autoplaySpeed: 7000,
        responsive: [{
          breakpoint: 1024,
          settings: {
            slidesToShow: 4,
            slidesToScroll: 3,
            infinite: true,
            dots: true
          }
        }, {
          breakpoint: 600,
          settings: {
            slidesToShow: 2,
            slidesToScroll: 2
          }
        }]
      }
    }
  },
  mounted() {
    axios.get(`${process.env.backendUrl}/api/landing/product/?status_id=2`)
    .then((response) => {
      this.dataProducts = response.data
    })
    .catch((e) => {
      console.log(e)
    })
    .finally(() => {
      this.loaded = true
    })
  },
  methods: {
    slickNext() {
      this.$refs.slider.next()
    },
    slickPrev() {
      this.$refs.slider.prev()
    }
  }
}
</script>
