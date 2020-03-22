import firebase_admin
import google
from firebase_admin import credentials, firestore
from operator import itemgetter

def insertionSort(highscore,leaderboard):
    count = 0
    max = len(leaderboard)
    for every_score in leaderboard:
        if every_score['highscore'] < highscore['highscore']:
            highscore['rank'] = every_score['rank']
            temp = leaderboard[count]
            leaderboard[count] = highscore
            count += 1
            break
        elif every_score['highscore'] == highscore['highscore']:
            if every_score['time_taken'] > highscore['time_taken']:
                highscore['rank'] = every_score['rank']
                temp = leaderboard[count]
                leaderboard[count] = highscore
                count += 1
                break
            else:
                count += 1
                if count == max:
                    highscore['rank'] = count + 1
                    leaderboard.append(highscore)
                    return
        else:
            count += 1
            if count == max:
                highscore['rank'] = count+1
                leaderboard.append(highscore)
                return
    while count < max:
        temp['rank'] = count+1
        temp2 = leaderboard[count]
        leaderboard[count] = temp
        temp = temp2
        count+=1
    temp['rank'] = count+1
    leaderboard.append(temp)




cred = credentials.Certificate('./ServiceAccountKey.json')
default_app = firebase_admin.initialize_app(cred)
db = firestore.client()
doc_ref = db.collection('Leaderboard')
second_ref = db.collection('HighScore')
doc = doc_ref.get()
second_doc = second_ref.get()

count = 0
highscore_id = list()
leaderboard_id = list()
document = list()

for docs in doc:
    document.append(docs.to_dict())
    leaderboard_id.append(docs.id)

document.sort(key=itemgetter('rank'), reverse=False)

for scores in second_doc:
    highscore = (scores.to_dict())
    #highscore['time_taken'] = highscore['time']
    #highscore['character'] = highscore['s_character']
    #highscore.pop('time')
    #highscore.pop('s_character')
    highscore_id.append(scores.id)
    insertionSort(highscore, document)
numbering = 1
for item in document:
    numberings = str(numbering)
    db.collection(u'Leaderboard').document(numberings).set(item)
    numbering += 1

for delete in leaderboard_id:
    db.collection(u'Leaderboard').document(delete).delete()
for delete2 in highscore_id:
    db.collection(u'HighScore').document(delete2).delete()