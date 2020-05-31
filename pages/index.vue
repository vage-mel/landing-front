<template>
  <div>
    <div class="main-wrap">
      <header-main />
      <div class="container-wrap">
        <section id="home">
          <video-banner />
          <div id="promotions">
            <promotions />
          </div>
        </section>
        <section id="all-new" class="space-top">
          <new-products />
        </section>
        <section id="trending" class="space-top">
          <trending />
        </section>
        <section id="categories" class="space-top">
          <categories />
        </section>
        <section id="featured" class="space-top-short">
          <featured-products />
        </section>
        <section id="testimonials" class="space-top">
          <testimonials />
        </section>
        <section id="blog">
          <blog />
        </section>
        <section id="feature" class="space-top-short">
          <feature />
        </section>
      </div>
      <section id="footer" class="space-top">
        <footer-main />
      </section>
      <hidden point="mdDown">
        <page-nav />
      </hidden>
      <hidden point="mdDown">
        <notification />
      </hidden>
    </div>
  </div>
</template>

<style scoped lang="scss">
@import '~/assets/styles';

@function section-margin($margin) {
  @return $margin * 20;
}
.main-wrap {
  position: relative;
  width: 100%;
  overflow: hidden;
  .theme--dark & {
    background-color: $dark-background-default;
  }
  .theme--light & {
    background-color: $light-background-paper;
  }
}
.space-bottom {
  margin-bottom: section-margin(6px);
  @include breakpoints-down(sm) {
    margin-bottom: section-margin(3px);
  }
  @include breakpoints-down(xs) {
    margin-bottom: section-margin(2px);
  }
}
.space-bottom-short {
  margin-bottom: section-margin($spacing1 / 2);
}
.space-top {
  margin-top: section-margin(6px);
  @include breakpoints-down(sm) {
    margin-top: section-margin(3px);
  }
  @include breakpoints-down(xs) {
    margin-top: section-margin(2px);
  }
}
.space-top-short {
  margin-top: section-margin($spacing1 / 2);
  @include breakpoints-down(sm) {
    margin-top: section-margin(3px);
  }
  @include breakpoints-down(xs) {
    margin-top: section-margin(2px);
  }
}
.container-wrap {
  margin-top: -40px;
  > section {
    position: relative;
  }
}
</style>

<script>
import Header from '~/components/Header'
import VideoBanner from '~/components/VideoBanner'
import Promotions from '~/components/Promotions'
import NewProducts from '~/components/NewProducts'
import Trending from '~/components/Trending'
import Categories from '~/components/Categories'
import FeaturedProducts from '~/components/FeaturedProducts'
import Testimonials from '~/components/Testimonials'
import Blog from '~/components/Blog'
import Feature from '~/components/Feature'
import Footer from '~/components/Footer'
import Hidden from '~/components/Hidden'
import PageNav from '~/components/PageNav'
import Notification from '~/components/Notification'
import brand from '~/static/text/brand'

export default {
  components: {
    'header-main': Header,
    VideoBanner,
    Promotions,
    NewProducts,
    Trending,
    Categories,
    FeaturedProducts,
    Testimonials,
    Blog,
    Feature,
    'footer-main': Footer,
    PageNav,
    Hidden,
    Notification
  },
  head() {
    return {
      title: brand.fashion.name + ' - Home Page'
    }
  }
}
</script>
