<template>
  <div>
    <el-button type="danger" @click="batchDelete">批量删除</el-button>
    <el-tree
      :data="menus"
      :props="defaultProps"
      :expand-on-click-node="false"
      show-checkbox
      node-key="catId"
      ref="menuTree"
      :default-expanded-keys="expandedKey">
    <span class="custom-tree-node" slot-scope="{ node, data }">
      <span>{{ node.label }}</span>
      <span>
        <el-button
          v-if="node.level <= 2"
          type="text"
          size="mini"
          @click="() => append(data)"
        >
          Append
        </el-button>
         <el-button type="text" size="mini" @click="() => edit(data)">
            Edit
          </el-button>
        <el-button
          v-if="node.childNodes.length == 0"
          type="text"
          size="mini"
          @click="() => remove(node, data)"
        >
          Delete
        </el-button>
      </span>
    </span>
    </el-tree>
    <el-dialog
      :title="title"
      :visible.sync="dialogVisible"
      width="30%"
      :close-on-click-modal="false"
    >
      <el-form :model="category">
        <el-form-item label="分类名称">
          <el-input v-model="category.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="图标">
          <el-input v-model="category.icon" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="计量单位">
          <el-input
            v-model="category.productUnit"
            autocomplete="off"
          ></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="submitData">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
  export default {
    name: 'category',
    components: {},
    directives: {},
    data() {
      return {
        menus: [],
        title: "",
        dialogType: "", //edit,add
        dialogVisible: false,
        expandedKey: [],
        category: {
          name: "",
          parentCid: 0,
          catLevel: 0,
          showStatus: 1,
          sort: 0,
          icon: "",
          productUnit: "",
          catId: null,
        },
        defaultProps: {
          children: 'childCategoryEntity',
          label: 'name'
        }
      };
    },
    mounted() {

    },
    methods: {
      // 批量删除
      batchDelete() {
        let catIds = [];
        let checkedNodes = this.$refs.menuTree.getCheckedNodes();
        console.log("被选中的元素", checkedNodes);
        for (let i = 0; i < checkedNodes.length; i++) {
          catIds.push(checkedNodes[i].catId);
        }

        this.$confirm(`是否批量删除【${catIds}】菜单?`, "提示", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning",
        })
          .then(() => {
            this.$http({
              url: this.$http.adornUrl("/product/category/delete"),
              method: "post",
              data: this.$http.adornData(catIds, false),
            })
              .then(({ data }) => {
                this.$message({
                  type: "success",
                  message: "菜单批量删除成功!",
                });
                // 刷新出新的菜单
                this.getMenus();
              })
              .catch(() => {});
          })
          .catch(() => {});
      },
      append(data) {
        console.log("append----", data);
        this.dialogType = "add";
        this.title = "添加分类";
        this.category.parentCid = data.catId;
        this.category.catLevel = data.catLevel * 1 + 1;
        this.category.catId = null;
        this.category.name = null;
        this.category.icon = "";
        this.category.productUnit = "";
        this.category.sort = 0;
        this.category.showStatus = 1;
        this.dialogVisible = true;
      },
      // 添加三级分类
      addCategory() {
        console.log("提交的三级分类数据", this.category);
        this.$http({
          url: this.$http.adornUrl("/product/category/save"),
          method: "post",
          data: this.$http.adornData(this.category, false),
        })
          .then(({data}) => {
            this.$message({
              type: "success",
              message: "菜单保存成功!",
            });
            this.dialogVisible = false;
            // 刷新出新的菜单
            this.getMenus();
            this.expandedKey = [this.category.parentCid];
            this. category={name: "", parentCid: 0, catLevel: 0, showStatus: 1, sort: 0}
          })
          .catch(() => {
          });
      },
      // 修改三级分类数据
      editCategory() {
        var { catId, name, icon, productUnit } = this.category;
        this.$http({
          url: this.$http.adornUrl("/product/category/update"),
          method: "post",
          data: this.$http.adornData({ catId, name, icon, productUnit }, false),
        })
          .then(({ data }) => {
            this.$message({
              type: "success",
              message: "菜单修改成功!",
            });
            // 关闭对话框
            this.dialogVisible = false;
            // 刷新出新的菜单
            this.getMenus();
            // 设置需要默认展开的菜单
            this.expandedKey = [this.category.parentCid];
          })
          .catch(() => {});
      },
      edit(data) {
        console.log("要修改的数据", data);
        this.dialogType = "edit";
        this.title = "修改分类";
        // 发送请求获取节点最新的数据
        this.$http({
          url: this.$http.adornUrl(`/product/category/info/${data.catId}`),
          method: "get",
        }).then(({ data }) => {
          // 请求成功
          console.log("要回显得数据", data);
          this.category.name = data.data.name;
          this.category.catId = data.data.catId;
          this.category.icon = data.data.icon;
          this.category.productUnit = data.data.productUnit;
          this.category.parentCid = data.data.parentCid;
          this.dialogVisible = true;
        });
      },
      submitData() {
        if (this.dialogType == "add") {
          this.addCategory();
        }
        if (this.dialogType == "edit") {
          this.editCategory();
        }
      },
      handleNodeClick(data) {
        console.log(data);
      },
      remove(node, data) {
        console.log("remove---", node);
        console.log("data---", data);
        var ids = [data.catId];

        this.$confirm(`是否删除【${data.name}】当前菜单?`, "提示", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning",
        })
          .then(() => {
            this.$http({
              url: this.$http.adornUrl("/product/category/delete"),
              method: "post",
              data: this.$http.adornData(ids, false),
            })
              .then(({data}) => {
                this.$message({
                  type: "success",
                  message: "菜单删除成功!",
                });
                // 刷新出新的菜单
                this.getMenus();
                this.expandedKey = [node.parent.data.catId]
              })
              .catch(() => {
              });
          })
          .catch(() => {
            this.$message({
              type: "info",
              message: "已取消删除",
            });
          });
      },
      getMenus() {
        this.$http({
          url: this.$http.adornUrl('/product/category/list/tree'),
          method: 'get'
        }).then(data => {
          this.menus = data.data;
          console.log(data)
        })
      }
    },
    created() {
      this.getMenus();
    }
  };
</script>

<style scoped>

</style>
