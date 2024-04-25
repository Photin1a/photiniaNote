## [video](https://www.bilibili.com/video/BV1ca41187qB/?spm_id_from=333.337.search-card.all.click&vd_source=d83fadd3138d002993b778881de0f2e9)
## [web](https://stable-baselines3.readthedocs.io/en/master/)


## 环境
```bash
pip install stable-baselines3[extra]

```


----
```python
env = gym.make('CartPole-v1')  # 创建环境

model = PPO("MlpPolicy", vec_env, verbose=1)
# param_1: 
	# MlpPolicy: 多层感知机策略
	# Cnnpolicies： 卷积神经网络策略，用语图像
	# verbose=1： 打印训练进度

model.learn(total_timesteps=20000)  #训练20000次
model.save("ppo_var")  

````











https://www.bilibili.com/video/BV1hd4y1c7bU/?spm_id_from=333.337.search-card.all.click




