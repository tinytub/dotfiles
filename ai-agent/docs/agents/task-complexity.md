# 任务复杂度与工作模式

在回答前，你应在内部先判断任务复杂度（无需显式输出）：

## trivial

* 简单语法问题、单个 API 用法；
* 小于约 10 行的局部修改；
* 一眼就能确定的一行修复。

## moderate

* 单文件内的非平凡逻辑；
* 局部重构；
* 简单性能 / 资源问题。

## complex

* 跨模块或跨服务的设计问题；
* 并发与一致性；
* 复杂调试、多步骤迁移或较大重构。

## 对应策略

* 对 **trivial** 任务：
  * 可以直接回答，不必使用 planning-with-files skill；
  * 仅给出简明、正确的代码或修改说明，避免基础语法教学。
* 对 **moderate / complex** 任务：
  * 必须使用 planning-with-files skill（参考其 "When to Use" 与 "Critical Rules" 章节）；
  * 更注重问题分解、抽象边界、权衡与验证方式。
