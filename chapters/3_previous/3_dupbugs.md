
## Duplicate bug report detection {#msr2013}

One of the steps in triaging an incoming change request is to determine whether
the request is a duplicate of another. This helps in quickly closing a
duplicate and also automatically linking it to the original, providing new
information about the change request. In large projects that receive tens to
hundreds of change requests a day, detecting duplication is critical for
quick triage.

In @Klein-etal_2014, we look at a new set of features that can help detect
duplicate requests using machine learning classifiers. Namely, we derive new
features from measures in the change request topic model and use these features
with 5 classifiers. We also looked at request length, similar words,
time, and priority, but the topic-based measures far outweigh these in terms of
information gain. The 15 features we investigated are as follows:

- Difference in the number of words in the:
    1. summaries
    2. descriptions
- Number of shared words after stemming and stop-word removal in the:
    3. summaries
    4. descriptions
- First shared identical topic between the sorted distribution given by LDA to
   each:
    5. summaries
    6. descriptions
    7. combined summaries and descriptions
- Hellinger distance between the topic distributions given by LDA to each:
    8. summaries
    9. descriptions
    10. combined summaries and descriptions
11. Difference in minutes between submission time of the bugs
12. If the request priorities were the same
13. If the requests were for the same program component (i.e., package)
14. If the requests were of the same type (i.e., bug report or feature request)
15. If the requests were marked as duplicates


To evaluate our new features, we used the dataset provided by
@Alipour-etal_2013. The dataset covers bug reports in Android, a mobile
operating system. We found that our features improved the accuracy of the 5
classifiers over @Alipour-etal_2013 by between 2.9% -- 16.74%, with the
classifier accuracies ranging between 92.9% -- 95.15%. We found that the
features that contributed the most information gain were numbers 5 (0.330), 7
(0.321), 8 (0.256), 3 (0.252), 10 (0.209), 6 (0.203), 9 (0.170), 4 (0.109).

In sum, we found that topic models provided reliable and simple measures that
highly increase the accuracy of duplicate request detection.
