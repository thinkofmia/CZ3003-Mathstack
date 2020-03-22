import firebase_admin
import google
from firebase_admin import credentials, firestore
from operator import itemgetter

def insertionSort(highscore,leaderboard):
    count = 0
    max = len(leaderboard)
    usernames_in = list()
    for every_score in leaderboard:
        if highscore['username'] in usernames_in:
            return
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
            usernames_in.append(every_score['username'])
            count += 1
            if count == max:
                highscore['rank'] = count+1
                leaderboard.append(highscore)
                return
    while count < max:
        if temp['username'] == highscore['username']:
            return
        temp['rank'] = count+1
        temp2 = leaderboard[count]
        leaderboard[count] = temp
        temp = temp2
        count+=1
    temp['rank'] = count+1
    leaderboard.append(temp)

##no need to call this function
def removeDuplicate(document):
    updated_document = list()
    for items in document:
        print(id_in)
        if items['username'] in id_in:
            print("in")
        else:
            id_in.append(items['username'])
            updated_document.append(items)

    for a in range(0, len(updated_document)):
        updated_document[a]['rank'] = a + 1
    return updated_document


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
id_in = list()
for docs in doc:
    document.append(docs.to_dict())
    leaderboard_id.append(docs.id)

document.sort(key=itemgetter('rank'), reverse=False)

for scores in second_doc:
    highscore = (scores.to_dict())
    highscore_id.append(scores.id)
    insertionSort(highscore, document)


for delete in leaderboard_id:
    db.collection(u'Leaderboard').document(delete).delete()

numbering = 1
for item in document:
    numberings = str(numbering)
    db.collection(u'Leaderboard').document(numberings).set(item)
    numbering += 1

for delete2 in highscore_id:
    db.collection(u'HighScore').document(delete2).delete()

# highscore['time_taken'] = highscore['time']
# highscore['character'] = highscore['s_character']
# highscore.pop('time')
# highscore.pop('s_character')