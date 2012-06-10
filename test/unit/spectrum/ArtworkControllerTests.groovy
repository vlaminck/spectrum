package spectrum



import org.junit.*
import grails.test.mixin.*

@TestFor(ArtworkController)
@Mock(Artwork)
class ArtworkControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/artwork/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.artworkInstanceList.size() == 0
        assert model.artworkInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.artworkInstance != null
    }

    void testSave() {
        controller.save()

        assert model.artworkInstance != null
        assert view == '/artwork/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/artwork/show/1'
        assert controller.flash.message != null
        assert Artwork.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/artwork/list'


        populateValidParams(params)
        def artwork = new Artwork(params)

        assert artwork.save() != null

        params.id = artwork.id

        def model = controller.show()

        assert model.artworkInstance == artwork
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/artwork/list'


        populateValidParams(params)
        def artwork = new Artwork(params)

        assert artwork.save() != null

        params.id = artwork.id

        def model = controller.edit()

        assert model.artworkInstance == artwork
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/artwork/list'

        response.reset()


        populateValidParams(params)
        def artwork = new Artwork(params)

        assert artwork.save() != null

        // test invalid parameters in update
        params.id = artwork.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/artwork/edit"
        assert model.artworkInstance != null

        artwork.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/artwork/show/$artwork.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        artwork.clearErrors()

        populateValidParams(params)
        params.id = artwork.id
        params.version = -1
        controller.update()

        assert view == "/artwork/edit"
        assert model.artworkInstance != null
        assert model.artworkInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/artwork/list'

        response.reset()

        populateValidParams(params)
        def artwork = new Artwork(params)

        assert artwork.save() != null
        assert Artwork.count() == 1

        params.id = artwork.id

        controller.delete()

        assert Artwork.count() == 0
        assert Artwork.get(artwork.id) == null
        assert response.redirectedUrl == '/artwork/list'
    }
}
