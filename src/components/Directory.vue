<template>
  <div class="directory">
    <p>{{ name }}<button @click="open">+</button></p>
    <p>{{ entries }}</p>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator';
import { Dropbox } from 'dropbox';

@Component
export default class Directory extends Vue {
  @Prop() private path: string = '';
  @Prop() private name!: string;
  @Prop() private dbx!: Dropbox;
  private entries: string = '';

  private get fullPath(): string {
    if (this.path === '' && this.name === '') {
      return '';
    }
    return `${this.path}/${this.name}`;
  }

  private async open(): Promise<void> {
    const files = await this.list_files();
    console.log(files);
    const names = files.entries.map((i) => i.name).join(',');
    console.log(names);
    this.entries = names;
  }

  private async list_files(): Promise<DropboxTypes.files.ListFolderResult> {
    console.log(`fullPath=${this.fullPath}`);
    return await this.dbx.filesListFolder({path: this.fullPath});
  }
}
</script>