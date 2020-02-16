from flask import Flask
import nltk, string
from sklearn.feature_extraction.text import TfidfVectorizer
nltk.download('punkt') # if necessary...
import json


app = Flask(__name__)

@app.route('/similarity')
def sim_func():
    stemmer = nltk.stem.porter.PorterStemmer()
    remove_punctuation_map = dict((ord(char), None) for char in string.punctuation)

    def stem_tokens(tokens):
        return [stemmer.stem(item) for item in tokens]

    '''remove punctuation, lowercase, stem'''
    def normalize(text):
        return stem_tokens(nltk.word_tokenize(text.lower().translate(remove_punctuation_map)))

    vectorizer = TfidfVectorizer(tokenizer=normalize, stop_words='english')

    def cosine_sim(text1, text2):
        tfidf = vectorizer.fit_transform([text1, text2])
        return ((tfidf * tfidf.T).A)[0,1]

#user's text input will be the JSON output of the Houndify speech-to-text. The "ground truth" text input is coming from the condition-kb
    case1 = str(cosine_sim('Diabetes refer to a group of diseases.', 'Diabetes mellitus refers to a group of diseases that affect how your body uses blood sugar (glucose). Glucose is vital to your health because its an important source of energy for the cells that make up your muscles and tissues. Its also your brains main source of fuel.'))
    case1json = json.dumps({"Similarity of Answers":case1})  
    return case1json

if __name__ == "__main__":
    app.debug = True
    app.run(host='0.0.0.0')


#Houndify sucks
""" @app.route('/input-text')
def getting_audio_input():
    class MyListener(houndify.HoundListener):
        def onPartialTranscript(self, transcript):
            t = transcript
            print("Partial transcript: " + transcript)

        def onFinalResponse(self, response):
            print("Final response: " + str(response))

        def onError(self, err):
            print("Error: " + str(err))
    client = houndify.StreamingHoundClient(<CLIENT_ID>, <CLIENT_KEY>, "test_user", sampleRate = 8000)
    BUFFER_SIZE = 512
    client.start(MyListener())

    while True:
        samples = sys.stdin.read(BUFFER_SIZE)
        if len(samples) == 0: break

    finished = client.fill(samples)
    if finished: break
    client.finish()
    
    return t


 """
