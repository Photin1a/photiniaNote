## [video](https://www.bilibili.com/video/BV1ca41187qB/?spm_id_from=333.337.search-card.all.click&vd_source=d83fadd3138d002993b778881de0f2e9)
## [web](https://stable-baselines3.readthedocs.io/en/master/)


## 环境
```bash
pip install stable-baselines3[extra]

```


----
```python
env = gym.make('CartPole-v1')  # 创建环境

model = PPO("MlpPolicy", learning_rate=0.005, gamma=0.99, verbose=1)
# param_1: 
	# MlpPolicy: 多层感知机策略
	# Cnnpolicies： 卷积神经网络策略，用语图像
	# learning_rate: 学习率
	# gamma：折扣因子
	# verbose=1： 打印训练进度

model.learn(total_timesteps=20000)  #训练20000次
model.save("ppo_carpole")  #保存模型

````

这两个参数的修改可能会影响训练过程和最终的性能：

- **学习率（`learning_rate`）**：学习率决定了模型参数更新的速度。较高的学习率可能会导致训练更快，但可能会影响模型的稳定性和最终性能。较低的学习率可能会导致训练更慢，但可能会得到更好的性能。
- **折扣因子（`gamma`）**：折扣因子决定了未来奖励的价值。较高的折扣因子值（接近1）会让算法更加关注长期的奖励，而较低的值（接近0）会让算法更加关注短期的奖励。









https://www.bilibili.com/video/BV1hd4y1c7bU/?spm_id_from=333.337.search-card.all.click




