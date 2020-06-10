<template>
  <div class="root" v-if="loaded">
    <v-container :class="{ 'fixed-width': isDesktop }">
      <v-row class="spacing3">
        <v-col md="3" cols="12">
          <title-main
            :align="isMobile ? 'center' : 'left'"
            primary="New"
            secondary="Arrivals"
          />
          <p class="use-text-paragrpah">
            {{ $t('fashionLanding.new_desc') }}
          </p>
        </v-col>
        <v-col md="3" sm="4" cols="12" v-for="product in products" :key="product.id">
          <product-ratting-card
            :img="product.img"
            :ratting="product.ratting"
            :text="product.short_description"
            :price="'$' + product.price"
            :id="product.id"
          />
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<style lang="scss" scoped>
@import './new-products-style.scss';
</style>

<script>
import imgAPI from '~/static/images/imgAPI'
import Title from '../Title'
import ProductRattingCard from '../Cards/ProductRatting'
import axios from 'axios'

export default {
  components: {
    'title-main': Title,
    ProductRattingCard
  },
  data() {
    return {
      products: [],
      loaded: false
    }
  },
  mounted() {
    axios.get(`${process.env.backendUrl}/api/landing/product/?status_id=1`)
    .then((response) => {
      this.products = response.data
    })
    .catch((e) => {
      console.log(e)
    })
    .finally(() => {
      this.loaded = true
    })
  },
  computed: {
    isDesktop() {
      const mdUp = this.$store.state.breakpoints.mdUp
      return mdUp.indexOf(this.$mq) > -1
    },
    isMobile() {
      const xsDown = this.$store.state.breakpoints.xsDown
      return xsDown.indexOf(this.$mq) > -1
    }
  }
}
</script>
