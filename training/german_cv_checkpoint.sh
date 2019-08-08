#!./bin/sh

#German Common Voice Dataset

set -xe

epoch_count=$1

python -u DeepSpeech.py --noshow_progressbar --noearly_stop \
  --train_files 'data_cv/cv/train.csv' --train_batch_size 2 \
  --dev_files 'data_cv/cv/dev.csv' --dev_batch_size 2 \
  --test_files 'data_cv/cv/test.csv' --test_batch_size 1 \
  --n_hidden 100 --epochs 20 \
  --max_to_keep 1 --checkpoint_dir 'checkpoints/ckpt_cv' \
  --learning_rate 0.0001 --dropout_rate 0.05 \
  --lm_binary_path 'data_cv/lm/lm.binary' \
  --lm_trie_path 'data_cv/lm/trie' | tee /tmp/resume.log

if ! grep "Restored variables from most recent checkpoint" /tmp/resume.log; then
  echo "Did not resume training from checkpoint"
  exit 1
else
  exit 0
fi
