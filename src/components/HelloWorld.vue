<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <input v-model="path" placeholder="path">
    <Directory :name="path" path="" :dbx="dbx" />
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator';
import { Dropbox } from 'dropbox';
import Directory from '@/components/Directory.vue';

@Component({
  components: {
    Directory,
  },
})
export default class HelloWorld extends Vue {
  @Prop() private msg!: string;
  private dbx: Dropbox;
  private path: string = '';
  private dirName: string|null = null;

  constructor() {
    super();
    this.dbx = new Dropbox({ accessToken: process.env.VUE_APP_DROPBOX_ACCESS_TOKEN });
    console.log(`secret: ${process.env.VUE_APP_DROPBOX_ACCESS_TOKEN}`);
  }

  private onAuthButtonClick(): void {
    this.dbx.getAuthenticationUrl('localhost:8080');
  }

  private async list_files(): Promise<any> {
    const response = await this.dbx.filesListFolder({path: this.path || ''});
    console.log(response);
    const names = response.entries.map((i) => i.name).join(',');
    console.log(names);
    this.dirName = names;
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="stylus">
h3
  margin 40px 0 0

ul
  list-style-type none
  padding 0

li
  display inline-block
  margin 0 10px

a
  color #42b983
</style>
