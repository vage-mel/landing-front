<template>
  <div class="root" v-if="loaded && categories">
    <v-container :class="{ 'fixed-width': isDesktop }">
      <v-row class="spacing3">
        <v-col md="6" cols="12">
          <title-main
            :align="isMobile ? 'center' : 'left'"
            primary="Top"
            secondary="Categories"
          />
        </v-col>
        <v-col md="3" sm="6" cols="12" v-for="index in [0, 1]" :key="index">
          <category-full-card v-if="index < categories.length"
            :img="categories[index].img"
            :title="categories[index].name"
            :total="categories[index].total"
            :background="categories[index].background"
          />
        </v-col>
      </v-row>
      <v-row class="spacing3">
        <v-col md="6" cols="12" class="py-0" v-if="2 < categories.length">
          <category-half-card
            :img="categories[2].img"
            :title="categories[2].name"
            :total="categories[2].total"
            :background="categories[2].background"
            type="top-over"
          />
          <v-row class="spacing3">
            <v-col md="6" sm="6" cols="12" v-for="index in [3, 4]" :key="index">
              <category-full-card v-if="index < categories.length"
                :img="categories[index].img"
                :title="categories[index].name"
                :total="categories[index].total"
                :background="categories[index].background"
              />
            </v-col>
          </v-row>
        </v-col>
        <v-col md="6" cols="12" class="py-0">
          <category-half-card v-if="5 < categories.length"
            :img="categories[5].img"
            :title="categories[5].name"
            :total="categories[5].total"
            :background="categories[5].background"
            type="bottom-over"
          />
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<style lang="scss" scoped>
@import './categories-style.scss';
</style>

<script>
import imgAPI from '~/static/images/imgAPI'
import Title from '../Title'
import CategoryHalfCard from '../Cards/CategoryHalf'
import CategoryFullCard from '../Cards/CategoryFull'
import axios from 'axios'

export default {
  components: {
    CategoryFullCard,
    CategoryHalfCard,
    'title-main': Title
  },
  data() {
    return {
      imgAPI: imgAPI,
      categories: [],
      loaded: false
    }
  },
  mounted() {
    axios.get(`http://127.0.0.1:8000/api/landing/category/`)
    .then((response) => {
      this.categories = response.data
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
      const lgUp = this.$store.state.breakpoints.lgUp
      return lgUp.indexOf(this.$mq) > -1
    },
    isMobile() {
      const xsDown = this.$store.state.breakpoints.xsDown
      return xsDown.indexOf(this.$mq) > -1
    }
  }
}
</script>
