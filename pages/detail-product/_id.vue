<template>
  <div class="main-wrap">
    <header-main invert />
    <main class="container-wrap">
      <v-row justify="center">
        <v-col sm="5" md="5" cols="12" class="px-6">
          <figure class="figure">
            <img :src="product.img" alt="product" />
          </figure>
        </v-col>
        <v-col sm="7" md="5" cols="12" class="px-6">
          <h4 class="use-text-title2">
            {{ product.title }}
          </h4>
          <p class="use-text-caption pb-2">
            {{ $t('fashionLanding.detail_id') }}
            :
            {{ product.id }}
          </p>
          <h4 class="price use-text-title2">
            $ {{ product.price }}
          </h4>
          <p class="desc text-paragraph">
            {{ product.description }}
          </p>
          <div class="size" v-if="product.size">
            {{ $t('fashionLanding.detail_size') }}
            <ul>
              <li>{{ product.size }}</li>
            </ul>
          </div>
          <v-btn
            large
            block
            color="primary"
            href="#"
            class="button"
          >
            {{ $t('fashionLanding.detail_btn') }}
          </v-btn>
        </v-col>
      </v-row>
    </main>
    <section class="space-top">
      <footer-main invert />
    </section>
  </div>
</template>

<style lang="scss" scoped>
.container-wrap {
  padding: spacing(15, 0);
  @inlcude breakpoints-down(sm) {
    margin: spacing(10, 0);
  }
}

.figure {
  text-align: center;
  img {
    max-width: 100%;
  }
}

.price {
  margin-top: $spacing3;
}

.desc {
  margin-top: $spacing3;
}

.size {
  text-transform: uppercase;
  margin: spacing(3, 0);
  display: flex;
  justify-content: space-between;
  align-items: center;
  @include breakpoints-down(sm) {
    flex-direction: column;
    align-items: flex-start;
    margin-top: $spacing6;
  }
  ul {
    display: inline-block;
    padding: 0;
    @include breakpoints-up(md) {
      margin: $spacing2;
      @include margin-left($spacing5);
    }
    li {
      width: 40px;
      height: 40px;
      line-height: 40px;
      border: 1px solid;
      @include use-theme(
        border-color,
        $palette-primary-dark,
        $palette-primary-light
      );
      text-align: center;
      @include margin-right($spacing1);
      display: inline-block;
      vertical-align: middle;
    }
  }
}
</style>

<script>
import imgAPI from '~/static/images/imgAPI'
import brand from '~/static/text/brand'
import Header from '~/components/Header'
import Footer from '~/components/Footer'
import axios from 'axios'

export default {
  components: {
    'header-main': Header,
    'footer-main': Footer,
  },
  mounted () {
    if (this.$route.params.id){
      axios.get(`http://127.0.0.1:8000/api/landing/product/${this.$route.params.id}`)
      .then((response) => {
        this.product = response.data
      })
      .catch((e) => {
        console.log(e)
      })
      .finally(() => {
        this.loaded = true
      })
    }
  },
  data: () => ({
    imgAPI: imgAPI,
    loaded: false,
    product: {}
  }),
  head() {
    return {
      title: brand.fashion.name + ' - Detail Product'
    }
  }
}
</script>
