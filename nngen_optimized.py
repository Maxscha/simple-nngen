# encoding=utf-8

import os
import time
import fire
from typing import List
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity
from nltk.translate.bleu_score import sentence_bleu

def load_data(path):
    """load lines from a file"""
    with open(path, 'r') as f:
        lines = f.read().split('\n')[0:-1]
    lines = [l.strip() for l in lines]
    return lines

def find_mixed_nn(simi, diffs, test_diff, bleu_thre :int =5) -> int:
    """Find the nearest neighbor using cosine simialrity and bleu score"""
    candidates = simi.argsort()[-bleu_thre:][::-1]
    max_score = 0
    max_idx = -1
    cnt = 0
    for j in candidates:
        if simi[j] < 0:
            return max_idx
        score = sentence_bleu([diffs[j].split()], test_diff.split())
        if score > max_score:
            max_score = score
            max_idx = j
        cnt = cnt + 1
    return max_idx

def nngen(train_diffs :List[str], counter:CountVectorizer, train_matrix, train_msgs :List[str], test_diffs :List[str],
          train_repos :List[str], test_repos :List[str],
          mode :"'exc': excludes test commit repo, 'inc': only includes test commit repo" ='def',
    bleu_thre :"how many candidates to consider before calculating bleu_score" =5, ) -> List[str]:
    """NNGen
    NOTE: currently, we haven't optmize for large dataset. You may need to split the 
    large training set into several chunks and then calculate the similarities between
    train set and test set to speed up the algorithm. You may also leverage GPU through
    pytorch or other libraries.
    """

    # print(len(counter.vocabulary_))

    # test_diffs = test_diffs[:9_763]

    test_matrix = counter.transform(test_diffs)
    print(test_matrix.shape)
    similarities = cosine_similarity(test_matrix, train_matrix)
    print("Similary calculated")
    test_msgs = []
    test_selected_repos = []
    for idx, test_simi in enumerate(similarities):
        if mode == 'exc':
            for i in range(test_simi.size):
                if train_repos[i] == test_repos[idx] or train_repos[i] == 'UNKNOWN' or test_repos[idx] == 'UNKNOWN':
                    test_simi[i] = -1
        if mode == 'inc':
            for i in range(test_simi.size):
                if train_repos[i] != test_repos[idx] or train_repos[i] == 'UNKNOWN' or test_repos[idx] == 'UNKNOWN':
                    test_simi[i] = -1
        if (idx + 1) % 100 == 0:
            print(idx+1)
        max_idx = find_mixed_nn(test_simi, train_diffs, test_diffs[idx], bleu_thre)
        if max_idx == -1:
            test_msgs.append("UNKONWN")
            test_selected_repos.append("UNKNOWN")
        else:
            test_msgs.append(train_msgs[max_idx])
            test_selected_repos.append(train_repos[max_idx])
    return (test_msgs, test_selected_repos)

def main(train_diff_file :str, train_msg_file :str, train_repos_file :str, 
         test_diff_file :str, test_repos_file :str, output_path :str = '/files/data/results/'):
    """Run NNGen with default given dataset using default setting"""
    test_basename = os.path.basename(test_diff_file)
    
    train_diffs = load_data(train_diff_file)
    train_msgs = load_data(train_msg_file)
    train_repos = load_data(train_repos_file)
    test_diffs = load_data(test_diff_file)
    test_repos = load_data(test_repos_file)



    os.makedirs(output_path, exist_ok=True)
        

    
    out_file =  f"{output_path}/nngen." + test_basename.replace('.diff', '.msg')
    counter = CountVectorizer(max_features=50_000)
    train_matrix = counter.fit_transform(train_diffs)
    print(train_matrix.shape)

    out = []

    
    n = 500
    l = int(len(test_diffs) / n)

    for i in range(0, n):
        print(i)
        test_diffs_sub = test_diffs[i*l:(i+1)*l]

        out_res = nngen(train_diffs, counter, train_matrix, train_msgs, test_diffs_sub, train_repos, test_repos)
        out.extend(out_res[0])
    
    with open(out_file, 'w') as out_f:
        out_f.write("\n".join(out) + "\n")

    
    
    # time_cost = time.time() -start_time
    # print("Done, cost {}s".format(time_cost))



if __name__ == "__main__":
    fire.Fire({
        'main':main
    })
